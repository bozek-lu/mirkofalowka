//
//  HotViewController.swift
//  Mirkofalowka
//
//  Created by Lu on 28/08/2016.
//  Copyright © 2016 wczoraj. All rights reserved.
//

import UIKit

class HotViewController: UIViewController {
    
    let loginManager = LoginManager()
    
    override func viewDidAppear(_ animated: Bool) {
        loginManager.hot()
    }
}

