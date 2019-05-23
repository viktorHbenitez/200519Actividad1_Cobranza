//
//  user.swift
//  200519Actividad1_Registro
//
//  Created by Victor Hugo Benitez Bosques on 20/05/19.
//  Copyright © 2019 Victor Hugo Benitez Bosques. All rights reserved.
//

import UIKit

class User: NSObject {

    var strName : String?
    var strDrossap: String?
    var strConfirmDrossap : String?
    var strEmail : String?
    var strDateBorn : String?
    var dteBorn : Date?
    var strNumEmployee : String?
    var strPhone : String?
    var strAddress : String?
    var strCompany : String?
    
    init(name : String , email : String, contraseña: String, numeroEmpledo : String, fechaNacimiento : String, telefono : String, strAddress : String? = nil, strCompany : String? =  nil) {
        
        self.strName = name
        self.strEmail = email
        self.strDrossap = contraseña
        self.strNumEmployee = numeroEmpledo
        self.strDateBorn = fechaNacimiento
        self.strPhone = telefono
        self.strAddress = strAddress
        self.strCompany = strCompany
    }
    
}
