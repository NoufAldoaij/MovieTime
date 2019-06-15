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
    
    func showPopUp(_ popup: UIViewController, isNavrHidden: Bool = true, parent: UIViewController){
        popup.view.backgroundColor = UIColor.white.withAlphaComponent(1)
        let nav = UINavigationController(rootViewController: popup)
        nav.setNavigationBarHidden(isNavrHidden, animated: false)
        let presStyle: UIModalPresentationStyle = (UIDevice.current.systemVersion as NSString).integerValue == 7 ? .currentContext : .overCurrentContext
        nav.modalPresentationStyle = presStyle
        parent.present(nav, animated: true, completion: nil)
    }

}
