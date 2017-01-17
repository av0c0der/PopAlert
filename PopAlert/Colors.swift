//
//  Colors.swift
//  PopAlert
//
//  Created by Abdurahim Jauzee on 17/01/2017.
//  Copyright © 2017 Abdurahim Jauzee. All rights reserved.
//

import UIKit


public extension UIColor {
    
    public static var tint: UIColor {
        return #colorLiteral(red: 0.9019607843, green: 0.1333333333, blue: 0.5490196078, alpha: 1)
    }
    
    public static var border: UIColor {
        return #colorLiteral(red: 0.5921568627, green: 0.5921568627, blue: 0.5921568627, alpha: 1).withAlphaComponent(0.08)
    }
    
    public static var activeText: UIColor {
        return UIColor.white
    }
    
    public static var inactiveText: UIColor {
        return UIColor.darkGray
    }
    
}
