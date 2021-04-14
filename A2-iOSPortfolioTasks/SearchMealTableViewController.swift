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
    
    var allMeals: [Meal] = []
    var filterMeals: [Meal] = []
    
    var noResult: Bool = true
    
    var indicator = UIActivityIndicatorView()
    
    weak var databaseController: DatabaseProtocol?


    override func viewDidLoad() {
        super.viewDidLoad()
        
//        createDefaultMeal()
        
        let searchController = UISearchController(searchResultsController: nil)
        searchController.searchBar.delegate = self
        searchController.obscuresBackgroundDuringPresentation = false
        searchController.searchBar.placeholder = "Search"
        navigationItem.searchController = searchController
        
        navigationItem.hidesSearchBarWhenScrolling = false
        
        //loding
        indicator.style = UIActivityIndicatorView.Style.large
        indicator.translatesAutoresizingMaskIntoConstraints = false
        self.view.addSubview(indicator)
        
        NSLayoutConstraint.activate([
                                        indicator.centerXAnchor.constraint(equalTo: view.safeAreaLayoutGuide.centerXAnchor),
                                        indicator.centerYAnchor.constraint(equalTo: view.safeAreaLayoutGuide.centerYAnchor)
        ])
    }
    
//    func createDefaultMeal() {
//        let ingMeas1 = IngredientMeasurement(name: "vanila", quantity: "1 tsp")
//        let ingMeas2 = IngredientMeasurement(name: "bd", quantity: "7 tsp")
//        let ingMeas3 = IngredientMeasurement(name: "kjkg", quantity: "1/2 tsp")
//
//        let ings1 = [ingMeas1,ingMeas2,ingMeas3]
//        let ings2 = [ingMeas2,ingMeas1,ingMeas3]
//        let ings3 = [ingMeas3,ingMeas2,ingMeas1]
//
//        allMeals.append(Meal(name: "abc", instructions: "fjowerhgfjhuiwhouhvwbjguiw gowij gfwrtoipjg gtrwoijgihp0394 t58902ujogv 34t209ujgvw 435t980pgw t49028- g3408-23 425n3opugv8fern ergiopu8  n543 w-[0v/s;er fjh0-w4", ingredients: ings1))
//        allMeals.append(Meal(name: "def", instructions: "9028- g3408-23 425n3opugv8fern ergiopu8  n543 w-[0v/s;er fjh0-w4", ingredients: ings2))
//        allMeals.append(Meal(name: "cdg", instructions: "jogv 34t209ujgvw 435t980pgw t49028- g3408-23 425n3opugv8fern ergiopu8  n543 w-[0v/s;er fjh0-w4", ingredients: ings3))
//    }
    
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
        
        URLSession.shared.invalidateAndCancel()
//        currentRequestIndex = 0
//        
//        requestBookNamed(searchText)
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
//        let heroAdded = databaseController?.addIngredientMeasurementToMeal(ingredientMeasurement: ingrendientMeasurement, meal: databaseController!) ?? false
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

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
