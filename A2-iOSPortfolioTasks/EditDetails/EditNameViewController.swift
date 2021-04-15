//
//  EditNameViewController.swift
//  A2-iOSPortfolioTasks
//
//  Created by Zigeng Feng on 4/10/21.
//

import UIKit

class EditNameViewController: UIViewController{
    @IBOutlet weak var nameTextField: UITextField!
    weak var nameDelegate: StrDelegate?

    @IBAction func saveButton(_ sender: Any) {
        if let name = nameTextField.text, !name.isEmpty {
            let _ = nameDelegate?.nameDelegate(name)
            navigationController?.popViewController(animated: true)
            return
        }
        else {
            displayMessage(title: "Error", message: "No Input")
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
