//
//  Empleado+CoreDataProperties.swift
//  200519Actividad1_Registro
//
//  Created by Victor Hugo Benitez Bosques on 24/05/19.
//  Copyright © 2019 Victor Hugo Benitez Bosques. All rights reserved.
//
//

import Foundation
import CoreData


extension Empleado {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Empleado> {
        return NSFetchRequest<Empleado>(entityName: "Empleado")
    }

    @NSManaged public var fullName: String?
    @NSManaged public var adress: String?
    @NSManaged public var dateBirth: NSDate?
    @NSManaged public var email: String?
    @NSManaged public var phoneNumber: Int16
    @NSManaged public var drowssap: String?

}
