//
//  AddIngrendientTableViewController.swift
//  A2-iOSPortfolioTasks
//
//  Created by Zigeng Feng on 4/10/21.
//

import UIKit

class AddIngrendientTableViewController: UITableViewController {
    
    var ingres: [IngreItem]? = nil
    let CELL_INGRE = "ingredientCell"
    override func viewDidLoad() {
        super.viewDidLoad()
        let temp = IngreJsonToStruct(jsonStr: ingreJson)
        ingres = temp.returnIngreArray()
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return 1
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let ingreCell = tableView.dequeueReusableCell(withIdentifier: CELL_INGRE, for: indexPath)
        let ingre = ingres![indexPath.row]
        ingreCell.textLabel?.text = ingre.strIngredient
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


struct IngreItem: Codable {
    var strIngredient: String
    var strDescription: String
}

class IngreJsonToStruct  {
    struct Ingresw: Codable {
        let meals: [IngreItem]
    }
    var tableData:Ingresw?
    init(jsonStr: String) {
        let jsonData = jsonStr.data(using: .utf8)!
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
func RequestJsonStr ()->() {
    let requestURL = URL(string: "https://www.themealdb.com/api/json/v1/1/list.php?i=list")!
    let task = URLSession.shared.dataTask(with: requestURL) {
        (data, response, error) in // This closure is executed on a different thread at a later point in // time!
        
    }
    task.resume()
}

let ingreJson = """
{
    "meals":
        [
            {
                "idIngredient": "1",
                "strIngredient": "Chicken",
                "strDescription": "The chie the mid-15th century BC, with",
                "strType": null
            }
        ]
}
"""

