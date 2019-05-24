//
//  MAPViewController.swift
//  200519Actividad1_Registro
//
//  Created by Victor Hugo Benitez Bosques on 23/05/19.
//  Copyright © 2019 Victor Hugo Benitez Bosques. All rights reserved.
//

import UIKit
import MapKit
import CoreLocation
import Contacts

class MAPViewController: UIViewController {

    @IBOutlet weak var lblName: UILabel!
    @IBOutlet weak var lblAdress: UILabel!
    @IBOutlet weak var lblAdeudo: UILabel!
    // 1
    let locationManager = CLLocationManager()
    var mapHasCenteredOnce = false

    var user : User?{
        didSet{
            loadViewIfNeeded()
            guard let userCo = user else {return}
            lblName.text = "Nombre : \(userCo.strName ?? "")"
            lblAdress.text = "Direccion: \(userCo.strAddress ?? "")"
            lblAdeudo.text = "Adeudo: $5000.00"
            
        }
    }
    
    let regionRadius: CLLocationDistance = 2000
    
    @IBOutlet weak var viewMap: MKMapView!{
        didSet{
            viewMap.delegate = self
            viewMap.showsScale = true
            viewMap.showsPointsOfInterest = true
            viewMap.showsUserLocation = true

        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // 2
        locationManager.delegate = self

        viewMap.userTrackingMode = MKUserTrackingMode.follow
        locationManager.requestLocation()  // Trae la localizacion
        locationManager.requestWhenInUseAuthorization()
        // 3
        if CLLocationManager.locationServicesEnabled() {
            locationManager.desiredAccuracy = kCLLocationAccuracyBest
            locationManager.startUpdatingLocation()
        }
        
        let artwork = Artwork(title: user?.strName ?? "",
                              locationName: user?.strAddress ?? "",
                              discipline: user?.strEmail ?? "",
                              coordinate: CLLocationCoordinate2D(latitude: user?.dblLatitud ?? 0, longitude: user?.dblLongitud ?? 0))
        viewMap.addAnnotation(artwork)
 
    }
  
  

    
}

extension MAPViewController : MKMapViewDelegate{
    func mapView(_ mapView: MKMapView, rendererFor overlay: MKOverlay) -> MKOverlayRenderer {
        let renderer = MKPolylineRenderer(polyline: overlay as! MKPolyline)
        renderer.strokeColor = UIColor.blue
        return renderer
    }
    
    
    func mapView(_ mapView: MKMapView, didUpdate userLocation: MKUserLocation) {
        
        if let location = userLocation.location{
            if !mapHasCenteredOnce{
                
                let destCoordination = CLLocationCoordinate2D(latitude: user?.dblLatitud ?? 0, longitude: user?.dblLongitud ?? 0)
                let sourceCordination = userLocation.location?.coordinate
                // placemak
                let sourcePlacemark =  MKPlacemark(coordinate: sourceCordination!)
                let destPlacermak = MKPlacemark(coordinate: destCoordination)
                
                let sourceMark = MKMapItem(placemark: sourcePlacemark)
                let destMark = MKMapItem(placemark: destPlacermak)
                
                // create direction
                let directionRequest = MKDirections.Request()
                directionRequest.source = sourceMark
                directionRequest.destination = destMark
                directionRequest.transportType = .automobile
                
                // add direction
                let directions = MKDirections(request: directionRequest)
                
                directions.calculate { [unowned self] response, error in
                    guard let unwrappedResponse = response else { return }
                    
                    for route in unwrappedResponse.routes {
                        self.viewMap.addOverlay(route.polyline)
                        self.viewMap.setVisibleMapRect(route.polyline.boundingMapRect, animated: true)
                    }
                }
                
                centerMapOnlocation(location)
                self.mapHasCenteredOnce = true
                
            }
            
        }
    }
    
    func centerMapOnlocation(_ location : CLLocation) {
        
        // Create a region
        let coordinateRegion = MKCoordinateRegion(center: location.coordinate,
                                                  latitudinalMeters: regionRadius, longitudinalMeters: regionRadius)
        
        // Set the region to the mapView
        self.viewMap.setRegion(coordinateRegion, animated: true)
        
    }
    
    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
        // 2
        guard let annotation = annotation as? Artwork else { return nil }
        // 3
        let identifier = "marker"
        var view: MKMarkerAnnotationView
        // 4
        if let dequeuedView = mapView.dequeueReusableAnnotationView(withIdentifier: identifier)
            as? MKMarkerAnnotationView {
            dequeuedView.annotation = annotation
            view = dequeuedView
        } else {
            // 5
            view = MKMarkerAnnotationView(annotation: annotation, reuseIdentifier: identifier)
            view.canShowCallout = true
            view.calloutOffset = CGPoint(x: -5, y: 5)
            view.rightCalloutAccessoryView = UIButton(type: .detailDisclosure)
        }
        return view
    }
    
    func mapView(_ mapView: MKMapView, annotationView view: MKAnnotationView,
                 calloutAccessoryControlTapped control: UIControl) {
        let location = view.annotation as! Artwork
        let launchOptions = [MKLaunchOptionsDirectionsModeKey: MKLaunchOptionsDirectionsModeDriving]
        location.mapItem().openInMaps(launchOptions: launchOptions)
    }

    
    
    
}

extension MAPViewController : CLLocationManagerDelegate{
   
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        if let location = locations.first{
            print("Location latitud: ", location.coordinate.latitude, "longitud: ", location.coordinate.longitude)
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print("error:: \(error.localizedDescription)")
    }

    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        
        switch status {
        case .notDetermined:
            locationManager.requestAlwaysAuthorization()
            viewMap.showsUserLocation = true
            
            break
        case .authorizedWhenInUse:
            locationManager.startUpdatingLocation()
            break
        case .authorizedAlways:
            locationManager.startUpdatingLocation()
            break
        case .restricted:
            // restricted by e.g. parental controls. User can't enable Location Services
            break
        case .denied:
            // user denied your app access to Location Services, but can grant access from Settings.app
            break
        default:
            break
        }
    }
    
}


class Artwork: NSObject, MKAnnotation {
    let title: String?
    let locationName: String
    let discipline: String
    let coordinate: CLLocationCoordinate2D
    
    init(title: String, locationName: String, discipline: String, coordinate: CLLocationCoordinate2D) {
        self.title = title
        self.locationName = locationName
        self.discipline = discipline
        self.coordinate = coordinate
        
        super.init()
    }
    
    var subtitle: String? {
        return locationName
    }
    
    // Annotation right callout accessory opens this mapItem in Maps app
    func mapItem() -> MKMapItem {
        let addressDict = [CNPostalAddressStreetKey: subtitle!]
        let placemark = MKPlacemark(coordinate: coordinate, addressDictionary: addressDict)
        let mapItem = MKMapItem(placemark: placemark)
        mapItem.name = title
        return mapItem
    }
}
