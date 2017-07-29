//
//  UserProfile.swift
//  Mirkofalowka
//
//  Created by Łukasz Bożek on 29/07/2017.
//  Copyright © 2017 wczoraj. All rights reserved.
//

import UIKit

class UserProfile: UIViewController {
    
    let contentProvider = ContentProvider()
    
    var user = ""
    
    override func viewDidLoad() {
        contentProvider.getUser(name: user) {
            
        }
    }
    @IBAction func dismissController(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
}
