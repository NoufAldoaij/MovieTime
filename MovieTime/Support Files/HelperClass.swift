//
//  HelperClass.swift
//  MovieTime
//
//  Created by Nouf Abdullah on 6/11/19.
//  Copyright © 2019 Nouf Abdullah. All rights reserved.
//

import Foundation
import UIKit
class HelperClass {
    
    func showAlert(title:String?, message:String?, _ viewController:UIViewController) {
        let alert = UIAlertController(title:title, message: message, preferredStyle: .alert)
        let action = UIAlertAction(title: "Dismiss", style: .default, handler: nil)
        alert.addAction(action)
        viewController.present(alert, animated: true, completion: nil)
    }
}
