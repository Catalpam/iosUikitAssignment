//
//  Measurement+CoreDataProperties.swift
//  A2-iOSPortfolioTasks
//
//  Created by Zigeng Feng on 4/10/21.
//
//

import Foundation
import CoreData


extension Measurement {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Measurement> {
        return NSFetchRequest<Measurement>(entityName: "IngrendientMeasurement")
    }

    @NSManaged public var name: String?
    @NSManaged public var quantity: String?
    @NSManaged public var measurementInMeal: Meal?

}

extension Measurement : Identifiable {
}
