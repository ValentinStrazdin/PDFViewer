//
//  UINavigationController+Extensions.swift
//  smartPortal
//
//  Created by Valentin Strazdin on 7/17/17.
//  Copyright © 2017 Fidelity National Title Group. All rights reserved.
//

import UIKit

extension UINavigationController {
    
    /// Pop to root view controller with completion
    ///
    /// - Parameters:
    ///   - flag: Set this value to true to animate the transition. Pass false if you are setting up a navigation controller before its view is displayed.
    ///   - completion: Action that should run after animation completed
    public func popToRootViewController(animated flag: Bool, completion: (() -> Swift.Void)? = nil) {
        CATransaction.begin()
        CATransaction.setCompletionBlock(completion)
        self.popToRootViewController(animated: flag)
        CATransaction.commit()
    }
    
    /// Pop view controller with completion
    ///
    /// - Parameters:
    ///   - flag: Set this value to true to animate the transition. Pass false if you are setting up a navigation controller before its view is displayed.
    ///   - completion: Action that should run after animation completed
    public func popViewController(animated flag: Bool, completion: (() -> Swift.Void)? = nil) {
        CATransaction.begin()
        CATransaction.setCompletionBlock(completion)
        self.popViewController(animated: flag)
        CATransaction.commit()
    }
    
}
