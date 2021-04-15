//
//  IngredientDetailViewController.swift
//  A2-iOSPortfolioTasks
//
//  Created by Zigeng Feng on 4/10/21.
//

import UIKit

class IngredientDetailViewController: UIViewController {
    var detailStr: String? = nil
    @IBOutlet weak var textView: UITextView!
    override func viewDidLoad() {
        textView.text = ingreDetail

        super.viewDidLoad()

        // Do any additional setup after loading the view.
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
