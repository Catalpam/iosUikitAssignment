//
//  IngredientDbContoller.swift
//  A2-iOSPortfolioTasks
//
//  Created by Zigeng Feng on 2021/4/14.
//
import Foundation
import CoreData
import UIKit
extension CoreDataController {
//    func addIngredient(name: String, strDescription: String) -> Ingredient {
//        let ingredient = NSEntityDescription.insertNewObject(forEntityName: "Ingredient", into: persistentContainer.viewContext) as! Ingredient
//        Ingredient.name = name
//        Ingredient.strDescription = strDescription
//        
//        return ingredient
//    }

    

    func deleteIngredient(ingredient: Ingredient) {
        persistentContainer.viewContext.delete(ingredient)
    }
    
    func fetchAllIngredient() -> [Ingredient] {
        if ingredientFetchedResultsController == nil {
            let fetchRequest: NSFetchRequest<Ingredient> = Ingredient.fetchRequest()
            let nameSortDescriptor = NSSortDescriptor(key: "strIngredient", ascending: true)
            fetchRequest.sortDescriptors = [nameSortDescriptor]

            ingredientFetchedResultsController = NSFetchedResultsController<Ingredient> (
                fetchRequest:fetchRequest,
                managedObjectContext: persistentContainer.viewContext,
                sectionNameKeyPath: nil,
                cacheName: nil
            )
            ingredientFetchedResultsController?.delegate = self
            
            do {
                try ingredientFetchedResultsController?.performFetch()
            } catch {
                print("Fetch request failed with error: \(error)")
            }
        }
        if let ingredients = ingredientFetchedResultsController?.fetchedObjects {
            return ingredients
        }
        return [Ingredient]()
    }
    
    func addIngredient(ingreItem: IngreItem) -> Ingredient {
        let ingredient = NSEntityDescription.insertNewObject(forEntityName:"Ingredient",into: persistentContainer.viewContext) as! Ingredient
        ingredient.strIngredient = ingreItem.strIngredient
        ingredient.strDescription = ingreItem.strDescription
        print("try add Ingredient")
        return ingredient
    }
}


