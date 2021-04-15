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
    case ingredient
    case mearsument
    case all
}

protocol DatabaseListener: AnyObject {
    var listenerType: ListenerType {get set}
    func onMealChange(change: DatabaseChange, meal: [Meal])
    func onMeasurementChange(change: DatabaseChange, ingredientMearsurement: [Measurement])
    func onIngredientListChange(ingredientList: [Ingredient])
}

protocol DatabaseProtocol: AnyObject {
    
//    var defaultMeal: Meal {get}

    func addListener(listener: DatabaseListener)
    func removeListener(listener: DatabaseListener)
    
    func addMeal(name: String, instruction: String) -> Meal
    func deleteMeal(meal: Meal)
    
    func addMeasurement(name: String, quantity: String) -> Measurement
    func deleteMeasurement(measurement: Measurement)
    
    func addIngredient(ingreItem: IngreItem) -> Ingredient
    func deleteIngredient(ingredient: Ingredient)

    
    func addMeasurementToMeal(measurement: Measurement, meal: Meal) -> Bool
    func MeasurementFromMeal(measurement: Measurement, meal: Meal)
    
    func cleanup()
}
