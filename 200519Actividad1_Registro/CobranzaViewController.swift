//
//  CobranzaViewController.swift
//  200519Actividad1_Registro
//
//  Created by Victor Hugo Benitez Bosques on 23/05/19.
//  Copyright © 2019 Victor Hugo Benitez Bosques. All rights reserved.
//

import UIKit

class CobranzaViewController: STConfigurationSecurityTableVC {

    
    var arrUser : [User]?
    var arrData : [DataSecurity]?
    override func viewDidLoad() {
        super.viewDidLoad()


        if let arrUsuarios = arrUser{
            arrData = [DataSecurity]()
            for user in arrUsuarios{
                arrData?.append(DataSecurity(strTitle: user.strName, strSubtitle: user.strStatusJob?.rawValue, strThird: user.strAddress, strFourData: user.strEmail, bCobranza: true) )
            }
            
            arrElements = arrData
        }
      
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.title = "Cobranza"
        self.navigationController?.setNavigationBarHidden(false, animated: animated)
        
    }
    
    
    override func btnShareAction() {
//        performSegue(withIdentifier: "mapa", sender: nil)
    }
    
    override func selectedElement(indexPath: IndexPath) {
        
        if indexPath.row == 0 || indexPath.row == 3{

        }else{
            performSegue(withIdentifier: "mapa", sender: indexPath)

        }
        
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let destinationVC = segue.destination as? MAPViewController{
            if let index = sender as? IndexPath{
                destinationVC.user = arrUser?[index.row]

            }
        }
    }


}
