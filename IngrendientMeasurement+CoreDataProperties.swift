//
//  IngrendientMeasurement+CoreDataProperties.swift
//  A2-iOSPortfolioTasks
//
//  Created by Zigeng Feng on 4/10/21.
//
//

import Foundation
import CoreData


extension IngrendientMeasurement {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<IngrendientMeasurement> {
        return NSFetchRequest<IngrendientMeasurement>(entityName: "IngrendientMeasurement")
    }

    @NSManaged public var name: String?
    @NSManaged public var quantity: String?
    @NSManaged public var measurement: Meal?

}

extension IngrendientMeasurement : Identifiable {

}
