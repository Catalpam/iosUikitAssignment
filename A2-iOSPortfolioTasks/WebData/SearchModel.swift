//
//  SearchModel.swift
//  A2-iOSPortfolioTasks
//
//  Created by Zigeng Feng on 2021/4/16.
//

import Foundation

class MealItem: Codable {
        var strMeal: String?
        var strInstructions: String?
        var strIngredient1: String?
        var strIngredient2: String?
        var strIngredient3: String?
        var strIngredient4: String?
        var strIngredient5: String?
        var strIngredient6: String?
        var strIngredient7: String?
        var strIngredient8: String?
        var strIngredient9: String?
        var strIngredient10: String?
        var strIngredient11: String?
        var strIngredient12: String?
        var strIngredient13: String?
        var strIngredient14: String?
        var strIngredient15: String?
        var strIngredient16: String?
        var strIngredient17: String?
        var strIngredient18: String?
        var strIngredient19: String?
        var strIngredient20: String?
        var strMeasure1: String?
        var strMeasure2: String?
        var strMeasure3: String?
        var strMeasure4: String?
        var strMeasure5: String?
        var strMeasure6: String?
        var strMeasure7: String?
        var strMeasure8: String?
        var strMeasure9: String?
        var strMeasure10: String?
        var strMeasure11: String?
        var strMeasure12: String?
        var strMeasure13: String?
        var strMeasure14: String?
        var strMeasure15: String?
        var strMeasure16: String?
        var strMeasure17: String?
        var strMeasure18: String?
        var strMeasure19: String?
        var strMeasure20: String?
}

var thisMeal: MealFinalItem? = nil

class MealFinalItem: Codable {
    var strMeal: String?
    var strInstruction: String?
    var strMeasures: [MeasureItem?] = []
    
    init(strMeal: String, strInstruction: String, strMeasures: [MeasureItem]) {
        self.strMeal = strMeal
        self.strInstruction = strInstruction
        self.strMeasures = strMeasures
    }
    
    init(mealItem :MealItem) {
        strMeal = mealItem.strMeal
        strInstruction = mealItem.strInstructions
        if mealItem.strIngredient1 != nil{
            if mealItem.strIngredient1!.count != 0 {
                strMeasures.append(MeasureItem(name: mealItem.strIngredient1!, quantity: mealItem.strMeasure1!))
            }
        }
        if mealItem.strIngredient2 != nil{
            if mealItem.strIngredient2!.count != 0 {
                strMeasures.append(MeasureItem(name: mealItem.strIngredient2!, quantity: mealItem.strMeasure2!))
            }
        }
        if mealItem.strIngredient3 != nil{
            if mealItem.strIngredient3!.count != 0 {
                strMeasures.append(MeasureItem(name: mealItem.strIngredient3!, quantity: mealItem.strMeasure3!))
            }
        }
        if mealItem.strIngredient4 != nil{
            if mealItem.strIngredient4!.count != 0 {
                strMeasures.append(MeasureItem(name: mealItem.strIngredient4!, quantity: mealItem.strMeasure4!))
            }
        }
        if mealItem.strIngredient5 != nil{
            if mealItem.strIngredient5!.count != 0 {
                strMeasures.append(MeasureItem(name: mealItem.strIngredient5!, quantity: mealItem.strMeasure5!))
            }
        }
        if mealItem.strIngredient6 != nil{
            if mealItem.strIngredient6!.count != 0 {
                strMeasures.append(MeasureItem(name: mealItem.strIngredient6!, quantity: mealItem.strMeasure6!))
            }
        }
        if mealItem.strIngredient7 != nil{
            if mealItem.strIngredient7!.count != 0 {
                strMeasures.append(MeasureItem(name: mealItem.strIngredient7!, quantity: mealItem.strMeasure7!))
            }
        }
        if mealItem.strIngredient8 != nil{
            if mealItem.strIngredient8!.count != 0 {
                strMeasures.append(MeasureItem(name: mealItem.strIngredient8!, quantity: mealItem.strMeasure8!))
            }
        }
        if mealItem.strIngredient9 != nil{
            if mealItem.strIngredient9!.count != 0 {
                strMeasures.append(MeasureItem(name: mealItem.strIngredient9!, quantity: mealItem.strMeasure9!))
            }
        }
        if mealItem.strIngredient10 != nil{
            if mealItem.strIngredient10!.count != 0 {
                strMeasures.append(MeasureItem(name: mealItem.strIngredient10!, quantity: mealItem.strMeasure10!))
            }
        }
        if mealItem.strIngredient11 != nil{
            if mealItem.strIngredient11!.count != 0 {
                strMeasures.append(MeasureItem(name: mealItem.strIngredient11!, quantity: mealItem.strMeasure11!))
            }
        }
        if mealItem.strIngredient12 != nil{
            if mealItem.strIngredient12!.count != 0 {
                strMeasures.append(MeasureItem(name: mealItem.strIngredient12!, quantity: mealItem.strMeasure12!))
            }
        }
        if mealItem.strIngredient13 != nil{
            if mealItem.strIngredient13!.count != 0 {
                strMeasures.append(MeasureItem(name: mealItem.strIngredient13!, quantity: mealItem.strMeasure13!))
            }
        }
        if mealItem.strIngredient14 != nil{
            if mealItem.strIngredient14!.count != 0 {
                strMeasures.append(MeasureItem(name: mealItem.strIngredient14!, quantity: mealItem.strMeasure14!))
            }
        }
        if mealItem.strIngredient15 != nil{
            if mealItem.strIngredient15!.count != 0 {
                strMeasures.append(MeasureItem(name: mealItem.strIngredient15!, quantity: mealItem.strMeasure15!))
            }
        }
        if mealItem.strIngredient16 != nil{
            if mealItem.strIngredient16!.count != 0 {
                strMeasures.append(MeasureItem(name: mealItem.strIngredient16!, quantity: mealItem.strMeasure16!))
            }
        }
        if mealItem.strIngredient17 != nil{
            if mealItem.strIngredient17!.count != 0 {
                strMeasures.append(MeasureItem(name: mealItem.strIngredient17!, quantity: mealItem.strMeasure17!))
            }
        }
        if mealItem.strIngredient18 != nil{
            if mealItem.strIngredient18!.count != 0 {
                strMeasures.append(MeasureItem(name: mealItem.strIngredient18!, quantity: mealItem.strMeasure18!))
            }
        }
        if mealItem.strIngredient19 != nil{
            if mealItem.strIngredient19!.count != 0 {
                strMeasures.append(MeasureItem(name: mealItem.strIngredient19!, quantity: mealItem.strMeasure19!))
            }
        }
        if mealItem.strIngredient20 != nil{
            if mealItem.strIngredient20!.count != 0 {
                strMeasures.append(MeasureItem(name: mealItem.strIngredient20!, quantity: mealItem.strMeasure20!))
            }
        }
    }
}


let mealJsonText = """
{
    "meals": [
        {
            "idMeal": "52771",
            "strMeal": "Spicy Arrabiata Penne",
            "strDrinkAlternate": null,
            "strCategory": "Vegetarian",
            "strArea": "Italian",
            "strInstructions": "Bring a large pot of watpg",
            "strTags": "Pasta,Curry",
            "strYoutube": "https://www.youtube.com/watch?v=1IszT_guI08",
            "strIngredient1": "penne rigate",
            "strIngredient2": "olive oil",
            "strIngredient3": "garlic",
            "strIngredient4": "chopped tomatoes",
            "strIngredient5": "red chile flakes",
            "strIngredient6": "italian seasoning",
            "strIngredient7": "basil",
            "strIngredient8": "Parmigiano-Reggiano",
            "strIngredient9": "",
            "strIngredient10": "",
            "strIngredient11": "",
            "strIngredient12": "",
            "strIngredient13": "",
            "strIngredient14": "",
            "strIngredient15": "",
            "strIngredient16": null,
            "strIngredient17": null,
            "strIngredient18": null,
            "strIngredient19": null,
            "strIngredient20": null,
            "strMeasure1": "1 pound",
            "strMeasure2": "1/4 cup",
            "strMeasure3": "3 cloves",
            "strMeasure4": "1 tin ",
            "strMeasure5": "1/2 teaspoon",
            "strMeasure6": "1/2 teaspoon",
            "strMeasure7": "6 leaves",
            "strMeasure8": "spinkling",
            "strMeasure9": "",
            "strMeasure10": "",
            "strMeasure11": "",
            "strMeasure12": "",
            "strMeasure13": "",
            "strMeasure14": "",
            "strMeasure15": "",
            "strMeasure16": null,
            "strMeasure17": null,
            "strMeasure18": null,
            "strMeasure19": null,
            "strMeasure20": null,
            "strSource": null,
            "strImageSource": null,
            "strCreativeCommonsConfirmed": null,
            "dateModified": null
        }
    ]
}
"""
