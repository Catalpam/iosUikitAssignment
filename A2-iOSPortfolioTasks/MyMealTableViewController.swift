//
//  MyMealTableViewController.swift
//  A2-iOSPortfolioTasks
//
//

import UIKit

class MyMealTableViewController: UITableViewController, DatabaseListener {

    let SECTION_MESUREMENT = 0
    let SECTION_COUNT = 1

    let CELL_MEAL = "myMealCell"
    let CELL_COUNT = "myMealSizeCell"

    var myMeals: [Meal] = []
    var listenerType = ListenerType.meal
    
    weak var databaseController: DatabaseProtocol?
    func onMealChange(change: DatabaseChange, meal: [Meal]) {
        myMeals = meal
    }
    
    func onMeasurementChange(change: DatabaseChange, ingredientMearsurement: [Measurement]) {
        //Do nothing
    }
    
    func onIngredientListChange(change: DatabaseChange, ingredientList: [Ingredient]) {
        //Do nothing
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        databaseController?.addListener(listener: self)
    }
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        databaseController?.removeListener(listener: self)
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        let appDelegate = UIApplication.shared.delegate as? AppDelegate
        databaseController = appDelegate?.databaseController
    }
    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 2
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        switch section {
            case SECTION_MESUREMENT:
                return myMeals.count
            case SECTION_COUNT:
                return 1
            default:
                return 0
        }
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.section == SECTION_MESUREMENT {
            let mealCell = tableView.dequeueReusableCell(withIdentifier: CELL_MEAL, for: indexPath)
            
            let meal = myMeals[indexPath.row]

            mealCell.textLabel?.text = meal.name
            mealCell.detailTextLabel?.text = meal.instructions
            return mealCell
        }

        let mealCountCell = tableView.dequeueReusableCell(withIdentifier: CELL_COUNT, for: indexPath)
            as! MealCountTableViewCell

        if myMeals.isEmpty {
            mealCountCell.mealCountLabel?.text = "Click + to add new meal"
        }
        else {
            mealCountCell.mealCountLabel?.text = "\(myMeals.count) Stored Meal"
        }

        return mealCountCell
    }

    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        if indexPath.section == SECTION_MESUREMENT {
            return true
        }

        return false
    }


    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete && indexPath.section == SECTION_MESUREMENT {
            // Delete the row from the data source
            tableView.performBatchUpdates({
                self.myMeals.remove(at: indexPath.row)
                self.tableView.deleteRows(at: [indexPath], with: .fade)
                self.tableView.reloadSections([SECTION_COUNT], with: .automatic)
            }, completion: nil)
        }
    }
}





//    func testMeal() {
//        let ingMeas1 = Measurement(name: "vanila", quantity: "1 tsp")
//        let ingMeas2 = Measurement(name: "bd", quantity: "7 tsp")
//        let ingMeas3 = Measurement(name: "kjkg", quantity: "1/2 tsp")
//
//        let ings1 = [ingMeas1,ingMeas2,ingMeas3]
//        let ings2 = [ingMeas2,ingMeas1,ingMeas3]
//        let ings3 = [ingMeas3,ingMeas2,ingMeas1]
//
//        myMeals.append(Meal(name: "test2", instructions: "fjowerhgfjhuiwhouhvwbjguiw gowij gfwrtoipjg gtrwoijgihp0394 t58902ujogv 34t209ujgvw 435t980pgw t49028- g3408-23 425n3opugv8fern ergiopu8  n543 w-[0v/s;er fjh0-w4", ingredients: ings1))
//        myMeals.append(Meal(name: "test1", instructions: "9028- g3408-23 425n3opugv8fern ergiopu8  n543 w-[0v/s;er fjh0-w4", ingredients: ings2))
//        myMeals.append(Meal(name: "test3", instructions: "jogv 34t209ujgvw 435t980pgw t49028- g3408-23 425n3opugv8fern ergiopu8  n543 w-[0v/s;er fjh0-w4", ingredients: ings3))
//    }

