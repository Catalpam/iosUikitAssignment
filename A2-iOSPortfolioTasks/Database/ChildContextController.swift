//
//  ChildContextController.swift
//  A2-iOSPortfolioTasks
//
//  Created by Zigeng Feng on 2021/4/16.
//

import Foundation
import CoreData

extension CoreDataController {
    func selectMeal(selectName: String) -> Meal? {
        let context = persistentContainer.viewContext
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "Meal")
        do {
            let resultList = try context.fetch(fetchRequest)as! [NSManagedObject]
            print("打印查询结果")
            for index in resultList as! [Meal] {
                print("查询到的Meal是\(index.name!)")
                if (index.name == selectName){
                    return index
                }
            }
        }
        catch let error {
            print("错误:\(error)")
            return nil
        }
        return nil
    }
    func selectMeasure(selectName: String, selectQuantity:String) -> Measurement? {
        let context = persistentContainer.viewContext
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "Measurement")
        do {
            let resultList = try context.fetch(fetchRequest)as! [NSManagedObject]
            print("打印查询结果")
            for index in resultList as! [Measurement] {
//                print("查询到的Meal是\(index.name!)")
                if (index.name == selectName && index.quantity == selectQuantity){
                    return index
                }
            }
        }
        catch let error {
            print("错误:\(error)")
            return nil
        }
        return nil
    }

    
    func editMealName(selectMeal: Meal, newName: String) {
        selectMeal.name = newName
        return
    }
    
    func editMealInstruction(selectMeal: Meal, newInstruction: String) {
        selectMeal.instructions = newInstruction
        return
    }
    
    func deleteMeal(meal: Meal) {
        persistentContainer.viewContext.delete(meal)
    }
}
