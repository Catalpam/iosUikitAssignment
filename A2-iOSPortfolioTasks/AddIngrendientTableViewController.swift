//
//  AddIngrendientTableViewController.swift
//  A2-iOSPortfolioTasks
//
//  Created by Zigeng Feng on 4/10/21.
//

import UIKit

class AddIngrendientTableViewController: UITableViewController, DatabaseListener {
    var listenerType: ListenerType = .ingredient
    weak var databaseController: DatabaseProtocol?
    var ingres: [IngreItem]? = nil
    var coreIngres: [Ingredient] = []
    let CELL_INGRE = "ingredientCell"
    var indicator = UIActivityIndicatorView()
    var measure = MeasureItem(name: "", quantity: "")
    
    weak var measureDelegate: StrDelegate?


    
    func onMealChange(change: DatabaseChange, meal: [Meal]) {
        //DoNothing
    }
    
    func onMeasurementChange(change: DatabaseChange, ingredientMearsurement: [Measurement]) {
        //DoNothing
    }
    
    func onIngredientListChange(ingredientList: [Ingredient]) { 
        coreIngres = ingredientList
        tableView.reloadData()
    }
    
    func textFieldAlart() {
        let alertController = UIAlertController(title: "Please add measurement", message: nil, preferredStyle: .alert)
        alertController.addTextField { (textField) in
            textField.placeholder = "Measurement"
        }
        self.present(alertController, animated: true)
        let continueAction = UIAlertAction(title: "Continue",style: .default) { [self, weak alertController] _ in
            guard let textFields = alertController?.textFields
            else {
                return
            }
            if let measurementText = textFields[0].text {
                print("Measurement: \(measurementText)")
                if measurementText.count != 0 {
                    self.measure.quantity = measurementText
                    let _ = measureDelegate?.measurementDelegate(self.measure)
                    navigationController?.popViewController(animated: true)
                    return
                }
                else {
                    self.displayMessage(title: "No Input", message: "Please type valid measurement.")
                }
            }
        }
        let backAction = UIAlertAction(title: "Back",style: .default) { _ in
            return
        }
        alertController.addAction(backAction)
        alertController.addAction(continueAction)

        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)

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
        let appDelegate = (UIApplication.shared.delegate as? AppDelegate)
        databaseController = appDelegate?.databaseController

        
        super.viewDidLoad()
        
        if UserDefaultsStore.hasLaunchBefore == false {
            // Add a loading indicator view
            indicator.style = UIActivityIndicatorView.Style.large
            indicator.translatesAutoresizingMaskIntoConstraints = false
            self.view.addSubview(indicator)
            NSLayoutConstraint.activate([
            indicator.centerXAnchor.constraint(equalTo: view.safeAreaLayoutGuide.centerXAnchor),
            indicator.centerYAnchor.constraint(equalTo: view.safeAreaLayoutGuide.centerYAnchor)
            ])
            indicator.startAnimating()
            RequestJsonStr ()
        }
    }
    


    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        if coreIngres.count != 0{
            return coreIngres.count
        }
        else if ingres != nil{
            return ingres!.count
        }
        else {
            return 0
        }
    }
//
    override func tableView(_ tableView: UITableView, accessoryButtonTappedForRowWith indexPath: IndexPath) {
        let ingre = coreIngres[indexPath.row]
        ingreDetail = ingre.strDescription!
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let ingreCell = tableView.dequeueReusableCell(withIdentifier: CELL_INGRE, for: indexPath)
        if coreIngres.count == 0{
            let ingre = ingres![indexPath.row]
            if ingre.strDescription == nil {
                ingreCell.accessoryType = .none
            }
            else {
                ingreCell.accessoryType = .detailButton
            }
            ingreCell.textLabel?.text = ingre.strIngredient

        }
        else {
            let ingre = coreIngres[indexPath.row]
            if ingre.strDescription == nil {
                ingreCell.accessoryType = .none
            }
            else {
                ingreCell.accessoryType = .detailButton
            }
            ingreCell.textLabel?.text = ingre.strIngredient
        }
        
        return ingreCell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.measure.name = coreIngres[indexPath.row].strIngredient!
        self.textFieldAlart()
        tableView.deselectRow(at: indexPath, animated: true)
    }

    
}


class IngreItem: Codable {
    var strIngredient: String
    var strDescription: String?
}

class IngreJsonToStruct  {
    struct Ingresw: Codable {
        let meals: [IngreItem]
    }
    var tableData:Ingresw?
    init(jsonData: Data) {
//        let jsonData = jsonStr.data
        do {
            let decoder = JSONDecoder()
            tableData = try decoder.decode(Ingresw.self, from: jsonData)
            print("Rows in array: \(String(describing: tableData?.meals.count))")
            print("\n\n\n\n\n\n")
        }
        catch {
            print("json decode failed:")
            print (error)
            tableData = nil
        }
    }
    
    func returnIngreArray() -> [IngreItem]? {
        if tableData != nil {
            print("json to str success")
            return tableData!.meals
        }
        else {
            return nil
        }
    }
}

extension AddIngrendientTableViewController {
    func RequestJsonStr ()->() {
        let requestURL = URL(string: "https://www.themealdb.com/api/json/v1/1/list.php?i=list")!
        let task = URLSession.shared.dataTask(with: requestURL) { (data, response, error) in
            // This closure is executed on a different thread at a later point in // time!
            if let error = error {
                print(error)
                return
            }
            let temp = IngreJsonToStruct(jsonData: data!)
            self.ingres = temp.returnIngreArray()
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
            
            for index in 0..<self.ingres!.count {
                let _ = self.databaseController?.addIngredient(ingreItem: self.ingres![index])
            }
            DispatchQueue.main.async {
                self.indicator.stopAnimating()
            }
            UserDefaultsStore.hasLaunchBefore = true

            print("First Launched!")
        }
        task.resume()
    }
}


let ingreJsonTest = """
{
    "meals":
        [
            {
                "idIngredient": "1",
                "strIngredient": "Chicken",
                "strDescription": "The chie the mid-15th century BC, with",
                "strType": null
            },
            {
                "idIngredient": "2",
                "strIngredient": "bus",
                "strDescription": null,
                "strType": null
            }
        ]
}
"""

