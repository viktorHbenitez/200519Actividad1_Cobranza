//
//  EmployeViewController.swift
//  200519Actividad1_Registro
//
//  Created by Victor Hugo Benitez Bosques on 20/05/19.
//  Copyright © 2019 Victor Hugo Benitez Bosques. All rights reserved.
//

import UIKit

class EmployeViewController: STConfigurationSecurityTableVC {

    
    var arrEmployees : [User]?
    override func viewDidLoad() {
        super.viewDidLoad()

        for employee in arrEmployees!{
            arrElements?.append(DataSecurity(strTitle: employee.strName, strSubtitle:  employee.strEmail))
        }
        
    
        
    }
    
//    arrElements = [DataSecurity(strTitle   : "Actualizar mi clave de seguridad",
//    strSubtitle: "Esta clave autoriza todas tus operaciones"),
//    DataSecurity(strTitle   : "Actualizar mi contraseña",
//    strSubtitle: "Con ella inicias sesión en tu App"),
//    DataSecurity(strTitle   : "Habilitar mi huella digital",
//    strSubtitle: "Tu huella será tu clave de seguridad y contraseña")]
    

}
