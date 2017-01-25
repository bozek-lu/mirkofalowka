//
//  MainTabBarController.swift
//  Mirkofalowka
//
//  Created by Lu on 25/01/2017.
//  Copyright © 2017 wczoraj. All rights reserved.
//

import UIKit

class MainTabBarController: UITabBarController, UITabBarControllerDelegate {
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.delegate = self
        
        NotificationCenter.default.addObserver(self, selector: #selector(self.updateBadge), name: NSNotification.Name(rawValue: Const.updateBadgeNotif), object: nil)
    }
    
    func tabBarController(_ tabBarController: UITabBarController,
                          didSelect viewController: UIViewController) {
        
        setTabBarVisible(visible: false, animated: true)
//        if let vc = viewController as? UINavigationController {
//            vc.popViewController(animated: false);
//        }
    }
    
    func updateBadge(notification: NSNotification) {
        let info = notification.userInfo as! Dictionary<String,AnyObject>
        
        let message = info[Const.orderValue] as! String
        
        tabBar.items?.first?.badgeValue = message
    }
}

