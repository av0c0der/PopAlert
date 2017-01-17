//
//  AlertControllerAppearance.swift
//  PopAlert
//
//  Created by Abdurahim Jauzee on 17/01/2017.
//  Copyright © 2017 Abdurahim Jauzee. All rights reserved.
//

import UIKit
import pop

extension AlertController {
    
    public static var appearance: AlertControllerAppearance {
        get {
            return Stored.options
        } set {
            Stored.options = newValue
        }
    }
    
    private struct Stored {
        static var options = AlertControllerAppearance()
    }
    
}

public struct AlertControllerAppearance {
    
    public var backgroundColor: UIColor = .white
    public var tintColor: UIColor = .tint
    public var font = UIFont.systemFont(ofSize: 16)
    public var activeTextColor: UIColor = .activeText
    public var inactiveTextColor: UIColor = .inactiveText
    public var cornerRadius: CGFloat = 0
    
    public var elementHeight: CGFloat = 50
    public var elementsInset: CGFloat = 40
    public var containerSideInset: CGFloat {
        return UIScreen.main.bounds.width * 0.12
    }
    
    public var shouldDimBackground = true
    public var backgroundDimmingColor = UIColor.black.withAlphaComponent(0.2)
    
    // MARK: Animation related properties
    public var presentingDuration: TimeInterval = 0.3
    public var dismissingDuration: TimeInterval = 0.3
    public var presentingAnimation: POPAnimation = AlertControllerAppearance.defaultPresentingAnimation
    public var dismissingAnimation: POPAnimation = AlertControllerAppearance.defaultDismissingAnimation
    

    private static var defaultPresentingAnimation: POPAnimation {
        let scaleAnimation = POPSpringAnimation(propertyNamed: kPOPLayerScaleXY)!
        scaleAnimation.springSpeed = 10
        scaleAnimation.springBounciness = 10
        scaleAnimation.fromValue = NSValue(cgPoint: CGPoint(x: 0.8, y: 0.8))
        return scaleAnimation
    }
    
    private static var defaultDismissingAnimation: POPAnimation {
        let scaleAnimation = POPSpringAnimation(propertyNamed: kPOPLayerScaleXY)!
        scaleAnimation.springSpeed = 15
        scaleAnimation.springBounciness = 3
        scaleAnimation.toValue = NSValue(cgPoint: CGPoint.zero)
        return scaleAnimation
    }
    
}
