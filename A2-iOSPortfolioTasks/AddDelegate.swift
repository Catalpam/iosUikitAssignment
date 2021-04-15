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

protocol StrDelegate: AnyObject {
    func nameDelegate(_ editName: String) -> Bool
    func introductionDelegate(_ editIntro: String) -> Bool
    func measurementDelegate(_ editMeasure: MeasureItem) -> Bool
}

protocol IngreDelegate: AnyObject {
    func addMeal(_ newIngre: Measurement) -> Bool
}

