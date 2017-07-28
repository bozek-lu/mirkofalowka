//
//  SettingsViewController.swift
//  Mirkofalowka
//
//  Created by Lu on 26/05/2017.
//  Copyright © 2017 wczoraj. All rights reserved.
//

import UIKit


class SettingsViewController: UIViewController {
    let loginProvider = LoginProvider()
    
    @IBAction func logowanie(_ sender: Any) {
        login()
        
    }
    
    func login() {
        loginProvider.login() { success in
            if success {
                print("wow")
            } else {
                NotificationCenter.default.post(name: Notification.Name("youNeedLoginNotif"), object: nil)
            }
        }
        
    }
}
