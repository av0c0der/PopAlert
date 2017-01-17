//
//  ViewController.swift
//  PopAlert
//
//  Created by Abdurahim Jauzee on 17/01/2017.
//  Copyright © 2017 Abdurahim Jauzee. All rights reserved.
//

import UIKit
import pop

class ViewController: UIViewController, UIViewControllerTransitioningDelegate {

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        
        let presentButton = UIButton(type: UIButtonType.system)
        presentButton.setTitle("Present PopAlert", for: UIControlState.normal)
        presentButton.addTarget(self, action: #selector(presentPopAlert(_:)), for: UIControlEvents.touchUpInside)
        view.addSubview(presentButton)
        presentButton.sizeToFit()
        presentButton.center = view.center
    }
    
    @objc private func presentPopAlert(_ sender: UIButton) {
        let titles = [
            "What's new",
            "Best selling",
            "Highest rated",
            "Price (Low to High)"
        ]
        
        Alert.show(with: titles, from: self)
    }
    
}
