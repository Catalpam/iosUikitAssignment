//
//  DetailTableViewController.swift
//  A2-iOSPortfolioTasks
//
//  Created by Zigeng Feng on 4/12/21.
//

import UIKit

class DetailTableViewController: UITableViewController, StrDelegate, DatabaseListener {
    var listenerType: ListenerType = .all
    
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
    
    var lastMeasurements:[Measurement] = []
    var lastMeals : [Meal] = []

    var deleteMeasure:[String] = []
    
    var measurements: [MeasureItem] = []
    weak var databaseController: DatabaseProtocol?

    
    @IBAction func saveButton(_ sender: Any) {
        
        if (thisMeal?.strMeasures.count) == 0 {
            displayMessage(title: "No Measurements", message: "Please input Measurement!")
            return
        }
        if (thisMeal?.strMeal) == nil {
            displayMessage(title: "No Meal Name", message: "Please input Meal Name!")
            return
        }
        if (thisMeal?.strInstruction) == nil {
            displayMessage(title: "No Instruction", message: "Please input Instruction!")
            return
        }
        let _ = self.databaseController?.addMeal(name: (thisMeal?.strMeal)!, instruction: (thisMeal?.strInstruction)!)

        for index in 0..<(thisMeal?.strMeasures.count)! {
            print(thisMeal?.strMeasures[index]!.name)
            print(index)
            let _ = self.databaseController?.addMeasurement(name: (thisMeal?.strMeasures[index]!.name)!, quantity: thisMeal!.strMeasures[index]!.quantity)
        }
        print("db try add")

        navigationController?.popViewController(animated: true)
    }
    

    func onMealChange(change: DatabaseChange, meal: [Meal]) {
        lastMeals = meal
        tableView.reloadData()
    }
    
    func onMeasurementChange(change: DatabaseChange, ingredientMearsurement: [Measurement]) {
        lastMeasurements = ingredientMearsurement
        tableView.reloadData()
    }
    
    func onIngredientListChange(ingredientList: [Ingredient]) {
        tableView.reloadData()
    }

    
    @IBOutlet weak var navigationTitle: UINavigationItem!
    var meal: Meal?
    
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        databaseController?.addListener(listener: self)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        databaseController?.removeListener(listener: self)
    }

    override func viewDidLoad() {
        let appDelegate = (UIApplication.shared.delegate as? AppDelegate)
        databaseController = appDelegate?.databaseController

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
                return (thisMeal?.strMeasures.count) ?? 0
            default:
                return 0
        }
    }
    
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.section == SECTION_NAME {
            let nameCell = tableView.dequeueReusableCell(withIdentifier: CELL_NAME, for: indexPath)
            if nameStr != "" {
                nameCell.textLabel?.text = nameStr
            }
            else if thisMeal?.strMeal != nil {
                nameCell.textLabel?.text = thisMeal!.strMeal!
                nameStr = thisMeal!.strMeal!
            }
            else {
                nameCell.textLabel?.text = "Tap to enter meal name"
            }
            
            return nameCell
        }
        
        else if indexPath.section == SECTION_INSTRUCTION {
            let instructionCell = tableView.dequeueReusableCell(withIdentifier: CELL_INSTRUCTION, for: indexPath)
            if introStr != "" {
                instructionCell.textLabel?.text = introStr
            }
            else if thisMeal?.strInstruction != nil {
                instructionCell.textLabel?.text = thisMeal!.strInstruction!
                introStr = thisMeal!.strInstruction!
            }
            else {
                instructionCell.textLabel?.text = "Tap to enter Introduction"
            }

            instructionCell.textLabel!.numberOfLines = 0
            return instructionCell
        }
        
        else if indexPath.section == SECTION_INGREDIENT {
            let ingredientCell = tableView.dequeueReusableCell(withIdentifier: CELL_INGREDIENT, for: indexPath) as! IngredientsTableViewCell
            ingredientCell.nameLabel?.text = thisMeal?.strMeasures[indexPath.row]?.name
            ingredientCell.meaurementLabel?.text = thisMeal?.strMeasures[indexPath.row]?.quantity
            return ingredientCell
        }
        
        let addCell = tableView.dequeueReusableCell(withIdentifier: CELL_ADD, for: indexPath)
        addCell.textLabel?.text = "Add Ingredient"
        return addCell
    }
    

    
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        if indexPath.section == SECTION_INGREDIENT {
            return true
        }
        return false
    }
    

    
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete && indexPath.section == SECTION_INGREDIENT {
            tableView.performBatchUpdates({
                thisMeal?.strMeasures.remove(at: indexPath.row)
                self.tableView.deleteRows(at: [indexPath], with: .fade)
                self.tableView.reloadSections([SECTION_INGREDIENT], with: .automatic)
            }, completion: nil)
        }
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
        if segue.identifier == "selectIngreSegue" {
            let destination = segue.destination as! AddIngrendientTableViewController
            destination.measureDelegate = self
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
        print(introStr)
        return true
    }
    func measurementDelegate(_ selectMeasure: MeasureItem) -> Bool {
        tableView.performBatchUpdates({
            thisMeal?.strMeasures.append(selectMeasure)
            tableView.insertRows(at: [IndexPath(row: (thisMeal?.strMeasures.count ?? 1)-1 , section: SECTION_INGREDIENT)], with: .automatic)
            tableView.reloadSections([SECTION_INGREDIENT], with: .automatic)
        },completion: nil)
        print("measurements.count")
        print(measurements.count)
        return true
    }
}
