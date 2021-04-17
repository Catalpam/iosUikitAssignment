//
//  CoreDataController.swift
//  A2-iOSPortfolioTasks
//
//  Created by Zigeng Feng on 4/12/21.
//

import UIKit
import CoreData

class CoreDataController: NSObject, DatabaseProtocol, NSFetchedResultsControllerDelegate {
    
    let DEFAULT_MEAL_NAME = "Default Meal"
    var listeners = MulticastDelegate<DatabaseListener>()
    var persistentContainer: NSPersistentContainer
    
    var mealFetchedResultsController: NSFetchedResultsController<Meal>?
    var ingredientFetchedResultsController: NSFetchedResultsController<Ingredient>?
    var measurementFetchedResultsController: NSFetchedResultsController<Measurement>?

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
    func noChange() {
        if persistentContainer.viewContext.hasChanges {
            persistentContainer.viewContext.rollback()
        }
    }

    
    func addListener(listener: DatabaseListener) {
        listeners.addDelegate(listener)
        
        if listener.listenerType == .meal || listener.listenerType == .all {
            listener.onMealChange(change: .update, meal: fetchAllMeals())
        }
        if listener.listenerType == .ingredient || listener.listenerType == .all {
            listener.onIngredientListChange(ingredientList: fetchAllIngredient())
        }
    }
    
    func removeListener(listener: DatabaseListener) {
        listeners.removeDelegate(listener)
    }

    
    // MARK: - Fetched Results Controller Protocol methods
    func controllerDidChangeContent(_ controller: NSFetchedResultsController<NSFetchRequestResult>) {
        if controller == mealFetchedResultsController {
            listeners.invoke() { (listener) in
                if listener.listenerType == .meal || listener.listenerType == .all {
                    listener.onMealChange(change: .update, meal: fetchAllMeals())
                }
            }
        }
        else if controller == ingredientFetchedResultsController {
            listeners.invoke() { (listener) in
                if listener.listenerType == .ingredient || listener.listenerType == .all {
                    listener.onIngredientListChange(ingredientList: fetchAllIngredient())
                }
            }

        }
        else if controller == measurementFetchedResultsController {
            listeners.invoke() { (listener) in
                if listener.listenerType == .mearsument || listener.listenerType == .all {
//                    listener.onMeasurementChange(change: .update, ingredientMearsurement: fetch())
                }
            }
        }
    }
}


