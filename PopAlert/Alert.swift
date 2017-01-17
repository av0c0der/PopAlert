//
//  Alert.swift
//  PopAlert
//
//  Created by Abdurahim Jauzee on 17/01/2017.
//  Copyright © 2017 Abdurahim Jauzee. All rights reserved.
//

import UIKit


class Alert {
   
    static func show(with titles: [String], from: UIViewController? = nil) {
        let controller = AlertController(with: titles)
        controller.modalPresentationStyle = .custom
        controller.modalPresentationStyle = .overCurrentContext
        controller.transitioningDelegate = controller
        
        var rootViewController: UIViewController?
        if let vc = from {
            rootViewController = vc
        } else {
            guard
                let keyWindow = UIApplication.shared.keyWindow,
                let vc = keyWindow.rootViewController else { return }
            rootViewController = vc
        }
        rootViewController?.present(controller, animated: true)
    }
    
}
