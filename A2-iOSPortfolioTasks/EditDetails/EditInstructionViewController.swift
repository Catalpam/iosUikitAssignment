//
//  EditInstructionViewController.swift
//  A2-iOSPortfolioTasks
//
//  Created by Zigeng Feng on 4/10/21.
//

import UIKit

class EditInstructionViewController: UIViewController {
    weak var introDelegate: StrDelegate?
    @IBOutlet weak var introTextField: UITextView!
    
    @IBAction func SaveButton(_ sender: Any) {
        if let intro = introTextField.text, !intro.isEmpty {
            let _ = introDelegate?.introductionDelegate(intro)
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
