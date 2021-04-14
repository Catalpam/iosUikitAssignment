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
    
    func deleteMeal(meal: Meal) {
        persistentContainer.viewContext.delete(meal)
    }
    
    func fetchAllMeals() -> [Meal] {
        var meals = [Meal]()
        let request: NSFetchRequest<Meal> = Meal.fetchRequest()
        
        do {
            try meals = persistentContainer.viewContext.fetch(request)
        } catch {
            print("Fetch request failed with error: \(error)")
        }
        
        return meals
    }

    //    func  creatDefaultMeals() {
//        let _ = addMeal(mealName: "hhhh")
//        let _ = addMeal(name: "hhh", instruction: "jjjj")
//        cleanup()
//    }
//

}
