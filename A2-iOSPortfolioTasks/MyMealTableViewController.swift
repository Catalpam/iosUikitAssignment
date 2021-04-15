//
//  MyMealTableViewController.swift
//  A2-iOSPortfolioTasks
//
//

import UIKit

class MyMealTableViewController: UITableViewController, DatabaseListener {

    let SECTION_MEAL = 0
    let SECTION_COUNT = 1

    let CELL_MEAL = "myMealCell"
    let CELL_COUNT = "myMealSizeCell"

    var myMeals: [Meal] = []
    var listenerType = ListenerType.meal
    
    weak var databaseController: DatabaseProtocol?
    func onMealChange(change: DatabaseChange, meal: [Meal]) {
        myMeals = meal
        tableView.reloadData()
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
            case SECTION_MEAL:
                return myMeals.count
            case SECTION_COUNT:
                return 1
            default:
                return 0
        }
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.section == SECTION_MEAL {
            let mealCell = tableView.dequeueReusableCell(withIdentifier: CELL_MEAL, for: indexPath)
            let meal = myMeals[indexPath.row]
            mealCell.textLabel?.text = meal.name
            mealCell.detailTextLabel?.text = meal.instructions
            return mealCell
        }

        let mealCountCell = tableView.dequeueReusableCell(withIdentifier: CELL_COUNT, for: indexPath)
        if myMeals.isEmpty {
            mealCountCell.textLabel?.text = "Click + to add new meal"
        }
        else {
            mealCountCell.textLabel?.text = "\(myMeals.count) Stored Meal"
        }
        return mealCountCell
    }

    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        if indexPath.section == SECTION_MEAL {
            return true
        }
        return false
    }


    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete && indexPath.section == SECTION_MEAL {
            // Delete the row from the data source
            tableView.performBatchUpdates({
                self.myMeals.remove(at: indexPath.row)
                self.tableView.deleteRows(at: [indexPath], with: .fade)
                self.tableView.reloadSections([SECTION_COUNT], with: .automatic)
            }, completion: nil)
        }
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if indexPath.section == SECTION_MEAL {
            let meal = myMeals[indexPath.row]
            self.tableView!.deselectRow(at: indexPath, animated: true)
            let nameStr = meal.name
            self.performSegue(withIdentifier: "editMealSegue", sender: nameStr)

        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "editMealSegue"{
            let controller = segue.destination as! DetailTableViewController
            controller.nameStr = sender as! String
        }
    }
}
