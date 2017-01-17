//
//  AnimationController.swift
//  PopAlert
//
//  Created by Abdurahim Jauzee on 17/01/2017.
//  Copyright © 2017 Abdurahim Jauzee. All rights reserved.
//

import UIKit
import pop


open class AnimationController: NSObject, UIViewControllerAnimatedTransitioning {
    
    private let kDimmingViewTag = 99
    fileprivate var presenting = true
    fileprivate var appearance: AlertControllerAppearance { return AlertController.appearance }
    
    convenience init(presenting: Bool) {
        self.init()
        self.presenting = presenting
    }
    
    open func transitionDuration(using transitionContext: UIViewControllerContextTransitioning?) -> TimeInterval {
        return presenting ? appearance.presentingDuration : appearance.dismissingDuration
    }
    
    open func animateTransition(using transitionContext: UIViewControllerContextTransitioning) {
        
        let modalViewKey: UITransitionContextViewControllerKey = presenting ? .to : .from
        let presentingViewKey: UITransitionContextViewControllerKey = presenting ? .from : .to
        
        guard let presentingView = transitionContext.viewController(forKey: presentingViewKey)?.view, let modalView = transitionContext.viewController(forKey: modalViewKey)?.view else { return }
        
        presentingView.isUserInteractionEnabled = !presenting
        presentingView.tintAdjustmentMode = presenting ? .dimmed : .normal
        
        if appearance.shouldDimBackground {
            if presenting {
                let dimView = UIView(frame: transitionContext.containerView.bounds)
                dimView.alpha = 0
                dimView.tag = kDimmingViewTag
                dimView.backgroundColor = appearance.backgroundDimmingColor
                transitionContext.containerView.addSubview(dimView)
                transitionContext.containerView.addSubview(modalView)
                UIView.animate(withDuration: transitionDuration(using: transitionContext)) {
                    dimView.alpha = 1
                }
            } else if let dimView = transitionContext.containerView.viewWithTag(kDimmingViewTag) {
                UIView.animate(withDuration: transitionDuration(using: transitionContext)) {
                    dimView.alpha = 0
                }
            }
        }
        
        let animation = presenting ? appearance.presentingAnimation : appearance.dismissingAnimation
        animation.completionBlock = { _ in
            transitionContext.completeTransition(true)
        }
        modalView.layer.pop_add(animation, forKey: "scaleAnimation")
    }
    
}
