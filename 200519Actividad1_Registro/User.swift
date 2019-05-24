//
//  user.swift
//  200519Actividad1_Registro
//
//  Created by Victor Hugo Benitez Bosques on 20/05/19.
//  Copyright © 2019 Victor Hugo Benitez Bosques. All rights reserved.
//

import UIKit

enum BDMJobStatus : String{
    case jefe = "Jefe"
    case subjefe = "Subjefe"
    case usuario = "Usuario"
}

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
    var strStatusJob : BDMJobStatus?
    var dblLatitud : Double
    var dblLongitud : Double
    
    init(name : String , email : String, contraseña: String, numeroEmpledo : String, fechaNacimiento : String, telefono : String, strAddress : String? = nil, strCompany : String? =  nil, job : BDMJobStatus = .usuario, latitud : Double, longitud :Double) {
        
        self.strName = name
        self.strEmail = email
        self.strDrossap = contraseña
        self.strNumEmployee = numeroEmpledo
        self.strDateBorn = fechaNacimiento
        self.strPhone = telefono
        self.strAddress = strAddress
        self.strCompany = strCompany
        self.strStatusJob = job
        self.dblLatitud = latitud
        self.dblLongitud = longitud
    }
    
    // 19.442380, -99.144119
    // 19.443604, -99.133143
    // 19.435372, -99.148338
    // 19.441432, -99.159807
    // 19.424672, -99.160985
    
}
