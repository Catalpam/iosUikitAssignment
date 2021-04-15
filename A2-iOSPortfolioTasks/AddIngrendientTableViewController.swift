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
    
    
    var ingres: [IngreItem]? = nil
    var coreIngres: [Ingredient]? = nil
    let CELL_INGRE = "ingredientCell"
    var indicator = UIActivityIndicatorView()
    
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
        
        // Add a loading indicator view
        indicator.style = UIActivityIndicatorView.Style.large
        indicator.translatesAutoresizingMaskIntoConstraints = false
        self.view.addSubview(indicator)
        NSLayoutConstraint.activate([
        indicator.centerXAnchor.constraint(equalTo: view.safeAreaLayoutGuide.centerXAnchor),
        indicator.centerYAnchor.constraint(equalTo: view.safeAreaLayoutGuide.centerYAnchor)
        ])
        
        super.viewDidLoad()
        
        indicator.startAnimating()
        RequestJsonStr ()

    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        if ingres == nil {
            return 0
        }
        else {
            if coreIngres == nil{
                return ingres!.count
            }
            else {
                return coreIngres!.count
            }
        }
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let ingreCell = tableView.dequeueReusableCell(withIdentifier: CELL_INGRE, for: indexPath)
        if coreIngres == nil{
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
            let ingre = coreIngres![indexPath.row]
            if ingre.strDescription == nil {
                ingreCell.accessoryType = .none
            }
            else {
                ingreCell.accessoryType = .detailButton
            }
            ingreCell.textLabel?.text = ingre.strIngredient
            print(ingre.strDescription as Any)

        }
        return ingreCell
    }
    

    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */
    
    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

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
            print("json解包失败")
            print (error)
            tableData = nil
        }
    }
    
    func returnIngreArray() -> [IngreItem]? {
        if tableData != nil {
            print("json to str 成功")
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
            
            let _ = self.databaseController?.addIngredient(ingreItem: self.ingres![0])
            
            DispatchQueue.main.async {
                self.indicator.stopAnimating()
            }
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

