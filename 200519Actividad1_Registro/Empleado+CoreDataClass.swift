//
//  Empleado+CoreDataClass.swift
//  200519Actividad1_Registro
//
//  Created by Victor Hugo Benitez Bosques on 23/05/19.
//  Copyright © 2019 Victor Hugo Benitez Bosques. All rights reserved.
//
//

import Foundation
import CoreData


public class Empleado: NSManagedObject {
    
    var age: Int {
        if let dob = dateBirth as Date? {
            return Calendar.current.dateComponents([.year], from: dob, to: Date()).year!
        }
        return 0
    }

}
