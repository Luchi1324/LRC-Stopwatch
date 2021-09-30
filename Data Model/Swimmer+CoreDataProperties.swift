//
//  Swimmer+CoreDataProperties.swift
//  LRC Stopwatch Stable
//
//  Created by Luciano Mattoli on 23/2/2021.
//
//

import Foundation
import CoreData


extension Swimmer {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Swimmer> {
        return NSFetchRequest<Swimmer>(entityName: "Swimmer")
    }

    @NSManaged public var distance: String?
    @NSManaged public var dob: String?
    @NSManaged public var eightHunFree: Float
    @NSManaged public var fifteenKFree: Float
    @NSManaged public var fiftyBack: Float
    @NSManaged public var fiftyBreast: Float
    @NSManaged public var fiftyFly: Float
    @NSManaged public var fiftyFree: Float
    @NSManaged public var fourHunFree: Float
    @NSManaged public var fourHunIM: Float
    @NSManaged public var gender: String?
    @NSManaged public var height: String?
    @NSManaged public var hunBack: Float
    @NSManaged public var hunBreast: Float
    @NSManaged public var hunFly: Float
    @NSManaged public var hunFree: Float
    @NSManaged public var name: String?
    @NSManaged public var stroke: String?
    @NSManaged public var twoHunBack: Float
    @NSManaged public var twoHunBreast: Float
    @NSManaged public var twoHunFly: Float
    @NSManaged public var twoHunFree: Float
    @NSManaged public var twoHunIM: Float
    @NSManaged public var weight: String?

}

extension Swimmer : Identifiable {

}
