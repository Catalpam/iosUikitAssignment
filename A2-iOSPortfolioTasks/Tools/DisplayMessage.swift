//
//  DisplayMessage-ext.swift
//  week3lab
//
//  Created by Zigeng Feng on 4/10/21.
//

import UIKit

extension UIViewController{
    func displayMessage(message:String, title: String) {
        let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
        
        alertController.addAction(UIAlertAction(title: "Dismiss", style: .default, handler: nil))
        
        self.present(alertController, animated: true, completion: nil)
    }
}

let userDefaults = UserDefaults.standard
var ingreDetail = ""
var ingres: [Measurement] = []
@propertyWrapper
struct UserDefaultWrapper<T> {
    let key: String
    let defaultValue: T

    init(_ key: String, defaultValue: T) {
        self.key = key
        self.defaultValue = defaultValue
    }

    var wrappedValue: T {
        get {
            return UserDefaults.standard.object(forKey: key) as? T ?? defaultValue
        }
        set {
            UserDefaults.standard.set(newValue, forKey: key)
        }
    }
}

struct UserDefaultsStore {
    @UserDefaultWrapper("has_launch_before", defaultValue: false)
    static var hasLaunchBefore: Bool
}



