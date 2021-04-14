//
//  IngredientDbContoller.swift
//  A2-iOSPortfolioTasks
//
//  Created by Zigeng Feng on 2021/4/14.
//

import Foundation

import Foundation
import CoreData
import UIKit
extension CoreDataController {
//    func addIngredient(name: String, ingredientDescription: String) -> Ingredient {
//        let ingredient = NSEntityDescription.insertNewObject(forEntityName: "Ingredient", into: persistentContainer.viewContext) as! Ingredient
//        Ingredient.name = name
//        Ingredient.ingredientDescription = ingredientDescription
//        
//        return ingredient
//    }
    func addIngredient(name: String, ingredientDescription: String) -> Ingredient {
        let ingrendient = NSEntityDescription.insertNewObject(forEntityName: "Ingredient", into: persistentContainer.viewContext) as! Ingredient
        ingrendient.name = name
        ingrendient.ingredientDescription = ingredientDescription
        return ingrendient
    }

    

    func deleteIngredient(ingredient: Ingredient) {
        persistentContainer.viewContext.delete(ingredient)
    }
    
    func fetchAllIngredient() -> [Ingredient] {
        var ingredients = [Ingredient]()
        let request: NSFetchRequest<Ingredient> = Ingredient.fetchRequest()
        
        do {
            try ingredients = persistentContainer.viewContext.fetch(request)
        } catch {
            print("Fetch request failed with error: \(error)")
        }
        
        return ingredients
    }
    
    func  creatDefaultMeals() {
        let _ = addMeal(mealName: "hhhh")
        let _ = addMeal(name: "hhh", instruction: "jjjj")
        cleanup()
    }
}


