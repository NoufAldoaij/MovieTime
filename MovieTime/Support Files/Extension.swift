//
//  Extension.swift
//  MovieTime
//
//  Created by Nouf Abdullah on 6/9/19.
//  Copyright © 2019 Nouf Abdullah. All rights reserved.
//

import Foundation
import UIKit

extension UIColor {
    convenience init(red: Int, green: Int, blue: Int) {
        assert(red >= 0 && red <= 255, "Invalid red component")
        assert(green >= 0 && green <= 255, "Invalid green component")
        assert(blue >= 0 && blue <= 255, "Invalid blue component")
        
        self.init(red: CGFloat(red) / 255.0, green: CGFloat(green) / 255.0, blue: CGFloat(blue) / 255.0, alpha: 1.0)
    }
    
    convenience init(netHex:Int) {
        self.init(red:(netHex >> 16) & 0xff, green:(netHex >> 8) & 0xff, blue:netHex & 0xff)
    }
}

extension UIView {
    func setViewWithBorder() {
        self.layer.cornerRadius = 10
        self.layer.borderColor = MovieTimeColors.lightGray_Color.cgColor
        self.layer.borderWidth = 1
    }
    
    func dropShadow() {
        //        self.layer.cornerRadius = 10
        //        self.layer.borderColor = MovieTimeColors.lightGray_Color.cgColor
        //        self.layer.borderWidth = 1
        //        self.layer.shadowColor = UIColor.black.cgColor
        //        self.layer.shadowOpacity = 0.8
        //        self.layer.shadowOffset = CGSize(width: -1, height: 1)
        //        self.layer.shadowRadius = 1
        //        self.layer.masksToBounds = false
        self.layer.cornerRadius = 10
        self.layer.borderColor = MovieTimeColors.lightGray.cgColor
        self.layer.borderWidth = 1.5
       self.layer.shadowColor = MovieTimeColors.lightGray_Color.cgColor
       self.layer.shadowOpacity = 0.2
       self.layer.shadowOffset = CGSize(width: 0, height: 5)
       self.layer.shadowRadius = 6
    }
    
    
}
