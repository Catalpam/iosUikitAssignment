//
//  SearchMealTableViewController.swift
//  A2-iOSPortfolioTasks
//
//
//  Created by Zigeng Feng on 2021/4/12.
//

import UIKit

class SearchMealTableViewController: UITableViewController, UISearchBarDelegate {
    
    let SECTION_SEARCH = 0
    let SECTION_ADD = 1
    
    let CELL_SEARCH = "searchMealCell"
    let CELL_ADD = "addSearchMealCell"
    
    let MEAL_REQUEST_STRING = "https://www.themealdb.com/api/json/v1/1/search.php?s=Arrabiata"
        
    var meals: [MealFinalItem] = []
    var noResult: Bool = true
    
    var indicator = UIActivityIndicatorView()
    
    weak var databaseController: DatabaseProtocol?


    override func viewDidLoad() {
        super.viewDidLoad()
                
        let searchController = UISearchController(searchResultsController: nil)
        searchController.searchBar.delegate = self
        searchController.obscuresBackgroundDuringPresentation = false
        searchController.searchBar.placeholder = "Search"
        navigationItem.searchController = searchController
        
        navigationItem.hidesSearchBarWhenScrolling = false
        
        indicator.style = UIActivityIndicatorView.Style.large
        indicator.translatesAutoresizingMaskIntoConstraints = false
        self.view.addSubview(indicator)
        NSLayoutConstraint.activate([
            indicator.centerXAnchor.constraint(equalTo: view.safeAreaLayoutGuide.centerXAnchor),
            indicator.centerYAnchor.constraint(equalTo: view.safeAreaLayoutGuide.centerYAnchor)
        ])
        
        
    }
    
//    // MARK: - Add Meal Delegate
//    func addMeal(_ newMeal: Meal) -> Bool {
//        tableView.performBatchUpdates({
//            allMeals.append(newMeal)
//            filterMeals.append(newMeal)
//
//            tableView.insertRows(at: [IndexPath(row: filterMeals.count-1, section: SECTION_SEARCH)], with: .automatic)
//            tableView.reloadSections([SECTION_ADD], with: .automatic)
//        }, completion: nil)
//        return true
//    }
//
    // MARK: - Search Protocol
    
    func searchBarTextDidEndEditing(_ searchBar: UISearchBar) {
        meals.removeAll()
        tableView.reloadData()
        indicator.startAnimating()
        
        guard let searchText = searchBar.text
        else {
            return
        }
        self.RequestJsonStr (queryStr: searchText)

    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return meals.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.section == SECTION_SEARCH {
            let searchMealCell = tableView.dequeueReusableCell(withIdentifier: CELL_SEARCH, for: indexPath)
            let meal = meals[indexPath.row]
            
            searchMealCell.textLabel?.text = meal.strMeal
            searchMealCell.detailTextLabel?.text = meal.strInstruction
            
            searchMealCell.detailTextLabel!.numberOfLines = 5

            
            return searchMealCell
        }
        
        let addCell = tableView.dequeueReusableCell(withIdentifier: CELL_ADD, for: indexPath)

        addCell.textLabel?.text = "Not what you were looking for? Tap to add a new meal"

        return addCell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        thisMeal = meals[indexPath.row]
        thisMeal?.strMeal = meals[indexPath.row].strMeal
        thisMeal?.strInstruction = meals[indexPath.row].strInstruction
        return
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let indexPath = self.tableView.indexPathForSelectedRow!
        tableView.performBatchUpdates({
            thisMeal?.strMeal = meals[indexPath.row].strMeal
            thisMeal?.strInstruction = meals[indexPath.row].strInstruction
            thisMeal = meals[indexPath.row]
        },completion: nil)
    }
    


    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        if indexPath.section == SECTION_SEARCH {
            return true
        }
        
        return false
    }

    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }
    }
}




extension SearchMealTableViewController {
    func RequestJsonStr (queryStr:String)->() {
        
        print("进入副线程，开始请求")
        let requestURL = URL(string: ("https://www.themealdb.com/api/json/v1/1/search.php?s=" + queryStr) )!
        print("搜索\(queryStr)")
        let task = URLSession.shared.dataTask(with: requestURL) { (data, response, error) in
            // This closure is executed on a different thread at a later point in // time!
            if let error = error {
                print(error)
                print("错误")
                return
            }
            let temp = MealJsonToStruct(jsonData: data!)
            if temp.tableData != nil{
                print("成功搜索到结果！")
                for index in 0..<temp.tableData!.meals.count {
                    let finalMeal = MealFinalItem(mealItem: temp.tableData!.meals[index])
                    print(finalMeal.strMeal as Any)
                    print(finalMeal.strInstruction as Any)
                    self.meals.append(finalMeal)
                }
            }
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
            DispatchQueue.main.async {
                self.indicator.stopAnimating()
            }
        }
        task.resume()
    }
}

class MealJsonToStruct {
    struct Mealw: Codable {
        let meals:[MealItem]
    }
    var tableData:Mealw?
    var finalMeal: MealFinalItem? = nil
    
    init(jsonData: Data) {
        do {
            let decoder = JSONDecoder()
            tableData = try decoder.decode(Mealw.self, from: jsonData)
            print("Meals Rows in array: \(String(describing: tableData?.meals.count))")
            print(tableData?.meals[0])
        }
        catch {
            print("json decode failed:")
            print (error)
            tableData = nil
        }
    }
}


