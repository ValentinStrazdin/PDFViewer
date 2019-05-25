//
//  NotificationCenter+Extension.swift
//  booking
//
//  Created by Valentin Strazdin on 4/18/18.
//  Copyright © 2018 wella. All rights reserved.
//

import UIKit

extension NotificationCenter {
    
    /// Here we are posting Notification on Main Thread so that UI changes will be processed correctly
    ///
    /// - Parameter aName: Notification Name
    @objc func postUINotification(name aName: NSNotification.Name) {
        DispatchQueue.main.async {
            NotificationCenter.default.post(name: aName, object: nil)
        }
    }
    
}
