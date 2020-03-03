//
//  MenuAnimator.swift
//  CyPhyHouse
//
//  Created by Suki on 2/26/20.
//  Copyright © 2020 CSL. All rights reserved.
//

import Foundation
import UIKit

// MARK: - PopinAnimator
class PopinAnimator: NSObject, UIViewControllerAnimatedTransitioning {
    let animationDuration = 0.5

    func transitionDuration(using transitionContext: UIViewControllerContextTransitioning?) -> TimeInterval {
        return animationDuration
    }
    
    func animateTransition(using transitionContext: UIViewControllerContextTransitioning) {
        guard let fromVC = transitionContext.viewController(forKey: .from),
            let toVC = transitionContext.viewController(forKey: .to) else { return }
        
        let transitionContainer = transitionContext.containerView
        
        toVC.view.frame = CGRect(x: -fromVC.view.frame.origin.x, y: 0, width: fromVC.view.frame.width, height: fromVC.view.frame.height)
        transitionContainer.addSubview(toVC.view)
        
        UIView.animate(withDuration: animationDuration, animations: { () -> Void in
            toVC.view.frame = CGRect(x: 0, y: 0, width: fromVC.view.frame.width, height: fromVC.view.frame.height)
        }, completion: { _ in
            transitionContext.completeTransition(true)
        })
    }
}

// MARK: - PopoutAnimator
class PopoutAnimator: NSObject, UIViewControllerAnimatedTransitioning {
    let animationDuration = 0.5

    func transitionDuration(using transitionContext: UIViewControllerContextTransitioning?) -> TimeInterval {
        return animationDuration
    }

    func animateTransition(using transitionContext: UIViewControllerContextTransitioning) {
        guard let fromVC = transitionContext.viewController(forKey: .from),
            let toVC = transitionContext.viewController(forKey: .to) else { return }

        let transitionContainer = transitionContext.containerView

        transitionContainer.addSubview(fromVC.view)

        UIView.animate(withDuration: animationDuration,
                       animations: { () -> Void in
                        fromVC.view.frame = CGRect(x: -toVC.view.frame.origin.x, y: 0, width: fromVC.view.frame.width, height: fromVC.view.frame.height)
        }, completion: {_ in
            transitionContext.completeTransition(true)
        })
    }
}
