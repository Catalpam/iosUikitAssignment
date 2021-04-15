//
//  CreateMealTableViewController.swift
//  A2-iOSPortfolioTasks
//
//  Created by Zigeng Feng on 4/10/21.
//

import UIKit

class CreateMealTableViewController: UITableViewController {
    let SECTION_NAME = 0
    let SECTION_INSTRUCTION = 1
    let SECTION_ADD = 2
    let SECTION_INGREDIENT = 3
    
    let CELL_NAME = "mealNameCell"
    let CELL_INSTRUCTION = "instructionCell"
    let CELL_ADD = "addIngredientCell"
    let CELL_INGREDIENT = "ingredientCell"
    
    var meal: Meal?
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if let meal = meal {
            navigationItem.title = meal.name
        }

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 4
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        switch section {
            case SECTION_NAME:
                return 1
            case SECTION_INSTRUCTION:
                return 1
            case SECTION_ADD:
                return 1
            case SECTION_INGREDIENT:
                return meal?.ingredients?.count ?? 0
            default:
                return 0
        }
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.section == SECTION_NAME {
            let nameCell = tableView.dequeueReusableCell(withIdentifier: CELL_NAME, for: indexPath)
            nameCell.textLabel?.text = meal?.name ?? "Tap to enter meal name"
            
            return nameCell
        } else if indexPath.section == SECTION_INSTRUCTION {
            let instructionCell = tableView.dequeueReusableCell(withIdentifier: CELL_INSTRUCTION, for: indexPath)
            instructionCell.textLabel?.text = meal?.instructions ?? "Tap to enter instructions"
            
            return instructionCell
        } else if indexPath.section == SECTION_ADD {
            let addCell = tableView.dequeueReusableCell(withIdentifier: CELL_ADD, for: indexPath)
            addCell.textLabel?.text = "Add Ingredient"
            
            return addCell
        }
        
        let ingredientCell = tableView.dequeueReusableCell(withIdentifier: CELL_INGREDIENT, for: indexPath) as! IngredientsTableViewCell
//        ingredientCell.nameLabel?.text = meal?.ingredients
//        ingredientCell.measurementLabel?.text = meal?.ingredients[indexPath.row].quantity
        
        return ingredientCell
    }
    

    
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    

    
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        
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
