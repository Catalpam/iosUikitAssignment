//
//  MealDbController.swift
//  A2-iOSPortfolioTasks
//
//  Created by Zigeng Feng on 2021/4/14.
//

import Foundation
import CoreData
import UIKit

extension CoreDataController {
    
    func addMeal(mealName: String) -> Meal {
        let meal = NSEntityDescription.insertNewObject(forEntityName: "Meal", into: persistentContainer.viewContext) as! Meal
        meal.name = mealName
        meal.instructions = ""
        return meal
    }
    
    func addMeal(name: String, instruction: String) -> Meal {
        let meal = NSEntityDescription.insertNewObject(forEntityName: "Meal", into: persistentContainer.viewContext) as! Meal
        meal.name = name
        meal.instructions = instruction
        return meal
    }
        
    
    func fetchAllMeals() -> [Meal] {
        if measurementFetchedResultsController == nil {
            
            let fetchRequest: NSFetchRequest<Meal> = Meal.fetchRequest()
            let nameSortDescriptor = NSSortDescriptor(key: "name", ascending: true)
            fetchRequest.sortDescriptors = [nameSortDescriptor]

            mealFetchedResultsController = NSFetchedResultsController<Meal> (
                fetchRequest:fetchRequest,
                managedObjectContext: persistentContainer.viewContext,
                sectionNameKeyPath: nil,
                cacheName: nil
            )
            mealFetchedResultsController?.delegate = self
            
            do {
                try mealFetchedResultsController?.performFetch()
            } catch {
                print("Fetch request failed with error: \(error)")
            }
        }
        if let meals = mealFetchedResultsController?.fetchedObjects {
            return meals
        }
        return [Meal]()
    }


    
    func addMeasurementToMeal(measurement: Measurement, meal: Meal) -> Bool {
        guard let ingres = meal.ingredients, ingres.contains(measurement) == false else {
            return false
        }
        meal.addToIngredients(measurement)
        return true
    }
    
    func removeMeasurementFromMeal(measurement: Measurement, meal: Meal) {
            meal.removeFromIngredients(measurement)
    }

}
