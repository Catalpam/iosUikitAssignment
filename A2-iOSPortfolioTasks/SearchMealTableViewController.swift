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
    
    let MEAL_REQUEST_STRING = "www.themealdb.com/api/json/v1/1/search.php?f=a"
    
    var mealJson: MealJson? = nil
    
    
    var allMeals: [Meal] = []
    var filterMeals: [Meal] = []
    
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
        
        //加载视图
        indicator.style = UIActivityIndicatorView.Style.large
        indicator.translatesAutoresizingMaskIntoConstraints = false
        self.view.addSubview(indicator)
        
        NSLayoutConstraint.activate([
            indicator.centerXAnchor.constraint(equalTo: view.safeAreaLayoutGuide.centerXAnchor),
            indicator.centerYAnchor.constraint(equalTo: view.safeAreaLayoutGuide.centerYAnchor)
        ])
    }
    
    // MARK: - Add Meal Delegate
    func addMeal(_ newMeal: Meal) -> Bool {
        tableView.performBatchUpdates({
            allMeals.append(newMeal)
            filterMeals.append(newMeal)
            
            tableView.insertRows(at: [IndexPath(row: filterMeals.count-1, section: SECTION_SEARCH)], with: .automatic)
            tableView.reloadSections([SECTION_ADD], with: .automatic)
        }, completion: nil)
        return true
    }
    
    // MARK: - Search Protocol
    
    func searchBarTextDidEndEditing(_ searchBar: UISearchBar) {
        filterMeals.removeAll()
        tableView.reloadData()
        
        guard let searchText = searchBar.text else {
            return
        }
        
        indicator.startAnimating()
        
        HttpRequest.search(keyword: searchText) {content, _ in
            self.mealJson = content
        }
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 2
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        switch section {
            case SECTION_SEARCH:
                return filterMeals.count
            case SECTION_ADD:
                if noResult {
                    return 0
                }
                return 1
            default:
                return 0
        }
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.section == SECTION_SEARCH {
            let searchMealCell = tableView.dequeueReusableCell(withIdentifier: CELL_SEARCH, for: indexPath)
            let meal = filterMeals[indexPath.row]
            
            searchMealCell.textLabel?.text = meal.name
            searchMealCell.detailTextLabel?.text = meal.instructions
            
            return searchMealCell
        }
        
        let addCell = tableView.dequeueReusableCell(withIdentifier: CELL_ADD, for: indexPath)

        addCell.textLabel?.text = "Not what you were looking for? Tap to add a new meal"

        return addCell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
//        let ingrendientMeasurement = [indexPath.row]
//        let heroAdded = databaseController?.addMeasurementToMeal(measurement: measurement, meal: databaseController!) ?? false
//        if heroAdded {
            navigationController?.popViewController(animated: false)
            return
//        }
//        displayMessage(title: "Party Full", message: "Unable to add more members to party")
//        tableView.deselectRow(at: indexPath, animated: true)

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
