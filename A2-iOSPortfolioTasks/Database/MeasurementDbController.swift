//
//  MeasurementDbController.swift
//  A2-iOSPortfolioTasks
//
//  Created by Zigeng Feng on 2021/4/14.
//

import Foundation
import CoreData
import UIKit

extension CoreDataController {

    func addMeasurement(name: String, quantity: String) -> Measurement {
        let Measurement = NSEntityDescription.insertNewObject(forEntityName: "Measurement", into: persistentContainer.viewContext) as! Measurement
        Measurement.name = name
        Measurement.quantity = quantity
        
        return Measurement
    }
    
    func deleteMeasurement(measurement: Measurement) {
        persistentContainer.viewContext.delete(measurement)
    }
    
    func addMeasurementToMeal(measurement: Measurement, meal: Meal) -> Bool {
        meal.addToIngredients(measurement)
        return true
    }
    
    func fetchAllMeasures() -> [Measurement] {
        var measurement = [Measurement]()
        let request: NSFetchRequest<Measurement> = Measurement.fetchRequest()
        
        do {
            try measurement = persistentContainer.viewContext.fetch(request)
        } catch {
            print("Fetch request failed with error: \(error)")
        }
        
        return measurement
    }


    func MeasurementFromMeal(measurement: Measurement, meal: Meal) {
    }

}
