//
//  DetailTableViewController.swift
//  A2-iOSPortfolioTasks
//
//  Created by Zigeng Feng on 4/12/21.
//

import UIKit

class DetailTableViewController: UITableViewController, StrDelegate {
    let SECTION_NAME = 0
    let SECTION_INSTRUCTION = 1
    let SECTION_INGREDIENT = 2
    let SECTION_ADD = 3
    
    let CELL_NAME = "mealNameCell"
    let CELL_INSTRUCTION = "instructionCell"
    let CELL_ADD = "addIngredientCell"
    let CELL_INGREDIENT = "ingredientCell"
    var nameStr: String = ""
    var introStr: String = ""

    
    @IBOutlet weak var navigationTitle: UINavigationItem!
    var meal: Meal?
    override func viewDidLoad() {
        super.viewDidLoad()
        if let meal = meal {
            navigationItem.title = meal.name
        }
        else{
            navigationItem.title = "Create a New Meal"
            
        }
        print("view did load")
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
                return meal?.ingredients?.count ?? 1
            default:
                return 0
        }
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.section == SECTION_NAME {
            let nameCell = tableView.dequeueReusableCell(withIdentifier: CELL_NAME, for: indexPath)
            if meal?.name == nil {
                if nameStr != "" {
                    nameCell.textLabel?.text = nameStr
                }
                else {
                    nameCell.textLabel?.text = "Tap to enter meal name"
                }
            }
            
            return nameCell
        }
        
        else if indexPath.section == SECTION_INSTRUCTION {
            let instructionCell = tableView.dequeueReusableCell(withIdentifier: CELL_INSTRUCTION, for: indexPath)
            if meal?.instructions == nil {
                if introStr != "" {
                    instructionCell.textLabel?.text = introStr
                }
                else {
                    instructionCell.textLabel?.text = "Tap to enter Introduction"
                }
            }
            instructionCell.textLabel!.numberOfLines = 0

            return instructionCell
        }
        
        else if indexPath.section == SECTION_INGREDIENT {
            let ingredientCell = tableView.dequeueReusableCell(withIdentifier: CELL_INGREDIENT, for: indexPath) as! IngredientsTableViewCell
            ingredientCell.nameLabel?.text = "1111111111"
            ingredientCell.meaurementLabel?.text = "21333233323333"
            return ingredientCell
        }
        
        let addCell = tableView.dequeueReusableCell(withIdentifier: CELL_ADD, for: indexPath)
        addCell.textLabel?.text = "Add Ingredient"
        return addCell
    }
    

    
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    

    
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "editNameSegue" {
            let destination = segue.destination as! EditNameViewController
            destination.nameDelegate = self
        }
        if segue.identifier == "editIntroSegue" {
            let destination = segue.destination as! EditInstructionViewController
            destination.introDelegate = self
        }

    }
}



extension DetailTableViewController {
    func nameDelegate(_ editName: String) -> Bool {
        tableView.performBatchUpdates({
            nameStr = editName
            print("nameStr")
            tableView.reloadSections([SECTION_NAME], with: .automatic)
        },completion: nil)
        return true
        
    }
    func introductionDelegate(_ editIntro: String) -> Bool {
        tableView.performBatchUpdates({
            introStr = editIntro
            tableView.reloadSections([SECTION_INSTRUCTION], with: .automatic)
        },completion: nil)
        return true
    }
    func measurementDelegate(_ Str: String) -> Bool {
        return true
    }
}
