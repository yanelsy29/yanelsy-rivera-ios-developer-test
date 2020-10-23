//
//  Car+CoreDataProperties.swift
//  
//
//  Created by yanelsy rivera on 10/22/20.
//
//

import Foundation
import CoreData

extension Car {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Car> {
        return NSFetchRequest<Car>(entityName: "Car")
    }

    @NSManaged public var numberPlate: String
    @NSManaged public var type: String
    @NSManaged public var parkings: NSSet?

}

// MARK: Generated accessors for parkings
extension Car {

    @objc(addParkingsObject:)
    @NSManaged public func addToParkings(_ value: Parking)

    @objc(removeParkingsObject:)
    @NSManaged public func removeFromParkings(_ value: Parking)

    @objc(addParkings:)
    @NSManaged public func addToParkings(_ values: NSSet)

    @objc(removeParkings:)
    @NSManaged public func removeFromParkings(_ values: NSSet)

}
