//
//  APIService.swift
//  200519CreateStoryboardNETEC
//
//  Created by Victor Hugo Benitez Bosques on 22/05/19.
//  Copyright © 2019 Victor Hugo Benitez Bosques. All rights reserved.
//

import UIKit
class APIService {
    
    let baseiTunesSearchURL = URL(string: "http://www.develogeeks.com/netec/capitulo4/consumoApi/Empleados/getList.php")!
    
    // Singleton
    static let shareInstance = APIService()
    
    func fetchEmployee(completionHandler:@escaping ([Employee]?) -> ()) {
        
        let request = URLRequest(url: baseiTunesSearchURL)
        URLSession.shared.dataTask(with: request) { (data, response, error) in
            guard let data = data else {
                return completionHandler(nil)
            }
            do{
                let result =  try JSONDecoder().decode(resultWS.self, from: data)
                
                return completionHandler(result.data)
            }catch let error{
                print(error)
                return completionHandler(nil)
            }
            }.resume()
    }
    
    
}

struct Employee: Codable {
    var idEmployee: Int?
    var fullName: String?
    var email: String?
    var photo: String?
    var address: String?
    var company: String?
    var area: String?
    var seniority: String?
    var dateInPayroll: String?
    var birthday: String?
    var age: String?
    var maritalStatus: String?
    var role: String?
    var productsPurchased: String?
//    var strDrossap: String = "12345"
    
    lazy var date: Date? = {
        guard let birthdaySring = birthday,
              let birthday = Double(birthdaySring) else {return nil}
        return Date(timeIntervalSince1970: birthday)
    }()
   
    init(name : String , email : String, contraseña: String, numeroEmpledo : String, fechaNacimiento : String, telefono : String, strAddress : String? = nil, strCompany : String? =  nil) {
        self.fullName = name
        self.email = email
//        self.strDrossap = contraseña
        
        self.birthday = String(converTimeInterval(strDate: fechaNacimiento))
//        self.strDrossap = contraseña
       
    }
    
    func converTimeInterval (strDate : String) -> Int{
        let dteFormaterr = DateFormatter()
        dteFormaterr.dateFormat = "dd-MM-yyy"
        if let dateStamp = dteFormaterr.date(from: strDate){
            return Int(dateStamp.timeIntervalSince1970)
        }
        
        return 0
    }
    
    /*
     var dfmatter = DateFormatter()
dfmatter.dateFormat="yyyy-MM-dd"
var date = dfmatter.date(from: "2016-12-1")
var dateStamp:TimeInterval = date!.timeIntervalSince1970
var dateSt:Int = Int(dateStamp)
     */

}

struct resultWS: Decodable{
    var data = [Employee]()
}




