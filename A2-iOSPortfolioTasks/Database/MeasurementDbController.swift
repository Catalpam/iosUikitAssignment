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
        let measurement = NSEntityDescription.insertNewObject(forEntityName: "Measurement", into: persistentContainer.viewContext) as! Measurement
        measurement.name = name
        measurement.quantity = quantity
        print("try addMeasurement")
        return measurement
    }
    
    

    
    func deleteMeasurement(measurement: Measurement) {
        persistentContainer.viewContext.delete(measurement)
    }
        
//    func fetchAllMeasures() -> [Measurement] {
//        var measurement = [Measurement]()
//        let request: NSFetchRequest<Measurement> = Measurement.fetchRequest()
//
//        do {
//            try measurement = persistentContainer.viewContext.fetch(request)
//        } catch {
//            print("Fetch request failed with error: \(error)")
//        }
//
//        return measurement
//    }
//

    func MeasurementFromMeal(measurement: Measurement, meal: Meal) {
    }
    
    func fetchAllMeasures() -> [Measurement] {
        if measurementFetchedResultsController == nil {
            let fetchRequest: NSFetchRequest<Measurement> = Measurement.fetchRequest()
            let nameSortDescriptor = NSSortDescriptor(key: "name", ascending: true)
            fetchRequest.sortDescriptors = [nameSortDescriptor]

            measurementFetchedResultsController = NSFetchedResultsController<Measurement> (
                fetchRequest:fetchRequest,
                managedObjectContext: persistentContainer.viewContext,
                sectionNameKeyPath: nil,
                cacheName: nil
            )
            measurementFetchedResultsController?.delegate = self
            
            do {
                try measurementFetchedResultsController?.performFetch()
            } catch {
                print("Fetch request failed with error: \(error)")
            }
        }
        if let measurements = measurementFetchedResultsController?.fetchedObjects {
            return measurements
        }
        return [Measurement]()
    }

}
