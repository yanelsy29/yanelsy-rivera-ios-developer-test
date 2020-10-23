//
//  Parking+CoreDataProperties.swift
//  
//
//  Created by yanelsy rivera on 10/23/20.
//
//

import Foundation
import CoreData


extension Parking {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Parking> {
        return NSFetchRequest<Parking>(entityName: "Parking")
    }

    @NSManaged public var dateIn: Date?
    @NSManaged public var dateOut: Date?
    @NSManaged public var id: Int16
    @NSManaged public var parkingTimeMinutes: Int16
    @NSManaged public var price: Double
    @NSManaged public var car: Car?

}
