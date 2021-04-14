//
//  MealData.swift
//  A2-iOSPortfolioTasks
//
//  Created by Zigeng Feng on 2021/4/14.
//

import UIKit


struct MealJson: Codable {
    var meals: [singleMeal]
    struct singleMeal: Codable {
        var strMeal: String?
        var strInstruction: String?
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
}


struct HttpRequest<T: Codable> {
    static func search (
        keyword: String,
        completion: @escaping(
            _ dataProcessed: T?,
            _ errorType: String?
        ) -> ()
    ) {
        let urlStr = "www.themealdb.com/api/json/v1/1/search.php?s=aaaaaaa"
        let url = URL(string: String(urlStr))!
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        URLSession.shared.dataTask(
            with: request
        ) { data, response, error in
//            if let error = error {
//                print("DataTask error in UserApi.getMyMessages: " + error.localizedDescription + "\n")
//                exit(-1)
//            } else
            if let data = data, let response = response as? HTTPURLResponse, response.statusCode == 200 {
                DispatchQueue.main.async {
                    let dataProcessed = try! JSONDecoder().decode(T.self, from: data)
                    completion(dataProcessed, nil)
                }
            }
        }.resume()
    }
}

func nullToNil(value : AnyObject?) -> AnyObject? {
    if value is NSNull {
        return nil
    } else {
        return value
    }
}

class Tools{
    static func setOptionalStr(value : Any?) -> String?{
        guard let string = value as! String?, !string.isEmpty else {
            return nil
        }
        return  value as? String
    }
}




//private enum RootKeys: String, CodingKey {
//    case name = "strMeal"
//    case imformaton = "strInstructions"
//    case strIngredient1
//    case strIngredient2
//    case strIngredient3
//    case strIngredient4
//    case strIngredient5
//    case strIngredient6
//    case strIngredient7
//    case strIngredient8
//    case strIngredient9
//    case strIngredient10
//    case strIngredient11
//    case strIngredient12
//    case strIngredient13
//    case strIngredient14
//    case strIngredient15
//    case strIngredient20
//    case strMeasure1
//    case strMeasure2
//    case strMeasure3
//    case strMeasure4
//    case strMeasure5
//    case strMeasure6
//    case strMeasure7
//    case strMeasure8
//    case strMeasure9
//    case strMeasure10
//    case strMeasure11
//    case strMeasure12
//    case strMeasure13
//    case strMeasure14
//    case strMeasure15
//    case strMeasure16
//    case strMeasure17
//    case strMeasure18
//    case strMeasure19
//    case strMeasure20
//}
