//
//  UIColorExtension.swift
//  ipinfo
//
//  Created by Oleksandr Vasildzhahaz on 30.05.2021.
//

import AVKit

extension UIColor {
    class var keyColor: UIColor {
        return UIColor(red: 15.0/255.0, green: 55.0/255.0, blue: 74.0/255.0, alpha: 1)
    }
    
    class var stringValueColor: UIColor {
        return UIColor(red: 136.0/255.0, green: 0.0/255.0, blue: 0.0/255.0, alpha: 1)
    }
    
    class var boolValueColor: UIColor {
        return UIColor(red: 124.0/255.0, green: 172.0/255.0, blue: 101.0/255.0, alpha: 1)
    }
    
    class var numberValueColor: UIColor {
        return UIColor(red: 205.0/255.0, green: 92.0/255.0, blue: 19.0/255.0, alpha: 1)
    }
}
