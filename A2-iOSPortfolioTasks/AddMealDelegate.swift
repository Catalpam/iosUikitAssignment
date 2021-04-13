//
//  File.swift
//  A2-iOSPortfolioTasks
//
//
//  Created by Zigeng Feng on 2021/4/12.
//

import Foundation

protocol AddMealDelegate: AnyObject {
    func addMeal(_ newMeal: Meal) -> Bool
}
