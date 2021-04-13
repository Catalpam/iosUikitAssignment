//
//  DatabaseProtocol.swift
//  A2-iOSPortfolioTasks
//
//  Created by Zigeng Feng on 4/12/21.
//

import Foundation

enum DatabaseChange {
    case add
    case remove
    case update
}

enum ListenerType {
    case meal
    case ingredientMearsument
    case all
}

protocol DatabaseListener: AnyObject {
    var listenerType: ListenerType {get set}
    func onMealChange(change: DatabaseChange, meal: [Meal])
    func onAllIngredientMeasurementChange(change: DatabaseChange, ingredientMearsurement: [IngrendientMeasurement])
    func onIngredientListChange(ingredientList: [Ingredient])
}

protocol DatabaseProtocol: AnyObject {
    func cleanup()
    
    var defaultMeal: Meal {get}

    func addListener(listener: DatabaseListener)
    func removeListener(listener: DatabaseListener)
    
    func addMeal(name: String, instruction: String) -> Meal
    func deleteMeal(meal: Meal)
    
    func addIngredientMeasurement(name: String, quantity: String) -> IngrendientMeasurement
    func deleteIngredientMeasurement(ingredientMeasurement: IngrendientMeasurement)
    
    func addIngredient(name: String, ingredientDescription: String) -> Ingredient
    
    func addIngredientMeasurementToMeal(ingredientMeasurement: IngrendientMeasurement, meal: Meal) -> Bool
    func removeIngredientMeasurementFromMeal(ingredientMeasurement: IngrendientMeasurement, meal: Meal)
    
}
