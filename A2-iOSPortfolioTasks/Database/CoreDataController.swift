//
//  CoreDataController.swift
//  A2-iOSPortfolioTasks
//
//  Created by Zigeng Feng on 4/12/21.
//

import UIKit
import CoreData

class CoreDataController: NSObject, DatabaseProtocol {
    
    let DEFAULT_MEAL_NAME = "Default Meal"

    lazy var defaultMeal: Meal = {
        var meals = [Meal]()
        let request: NSFetchRequest<Meal> = Meal.fetchRequest()
        let predicate = NSPredicate(format: "name = %@", DEFAULT_MEAL_NAME)
        request.predicate = predicate
        do {
            try meals = persistentContainer.viewContext.fetch(request)
        } catch {
            print("Fetch Request Failed: \(error)")
        }
        
        if let firstMeal = meals.first {
            return firstMeal
        }
        return addMeal(mealName: DEFAULT_MEAL_NAME)
    }()
    
    func addMeal(mealName: String) -> Meal {
        let meal = NSEntityDescription.insertNewObject(forEntityName: "Meal", into: persistentContainer.viewContext) as! Meal
        meal.name = mealName
        
        return meal
    }

    
    var mealFetchedResultsController: NSFetchedResultsController<Meal>?
    var allIngredientFetchedResultsController: NSFetchedResultsController<Ingredient>?
    var allIngrendientMeasurementFetchedResultsController: NSFetchedResultsController<IngrendientMeasurement>?

    
    var listeners = MulticastDelegate<DatabaseListener>()
    var persistentContainer: NSPersistentContainer
    
    override init() {
        persistentContainer = NSPersistentContainer(name: "MealModel")
        persistentContainer.loadPersistentStores() { (description, error ) in
            if let error = error {
                fatalError("Failed to load Core Data Stack with error: \(error)")
            }
        }
        
        super.init()
    }
    
    // Save changes inside view context if necessary
    func cleanup() {
        if persistentContainer.viewContext.hasChanges {
            do {
                try persistentContainer.viewContext.save()
            } catch {
                fatalError("Failed to save changes to Core Data with error: \(error)")
            }
        }
    }
    
    func addListener(listener: DatabaseListener) {
        listeners.addDelegate(listener)
        
        if listener.listenerType == .meal || listener.listenerType == .all {
            listener.onMealChange(change: .update, meal: fetchAllMeals())
        }
    }
    
    func removeListener(listener: DatabaseListener) {
        listeners.removeDelegate(listener)
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
    
    func addIngredientMeasurement(name: String, quantity: String) -> IngrendientMeasurement {
        let ingrendientMeasurement = NSEntityDescription.insertNewObject(forEntityName: "IngrendientMeasurement", into: persistentContainer.viewContext) as! IngrendientMeasurement
        ingrendientMeasurement.name = name
        ingrendientMeasurement.quantity = quantity
        
        return ingrendientMeasurement
    }
    
    func deleteIngredientMeasurement(ingredientMeasurement: IngrendientMeasurement) {
        persistentContainer.viewContext.delete(ingredientMeasurement)
    }
    
    func addIngredientMeasurementToMeal(ingredientMeasurement: IngrendientMeasurement, meal: Meal) -> Bool {
        guard let ingredientMeasurements = meal.ingredients, ingredientMeasurements.contains(ingredientMeasurement) == false  else {
            return false
        }
        
        meal.addToIngredients(ingredientMeasurement)
        return true
    }

    func removeIngredientMeasurementFromMeal(ingredientMeasurement: IngrendientMeasurement, meal: Meal) {
    }
    
    func addIngredient(name: String, ingredientDescription: String) -> Ingredient {
        let ingrendient = NSEntityDescription.insertNewObject(forEntityName: "Ingredient", into: persistentContainer.viewContext) as! Ingredient
        ingrendient.name = name
        ingrendient.ingredientDescription = ingredientDescription
        return ingrendient
    }
    
    
    func  createDefaultHeroes() {
        let _ = addMeal(mealName: "hhhh")
        let _ = addMeal(name: "hhh", instruction: "jjjj")
        cleanup()

    }

}
