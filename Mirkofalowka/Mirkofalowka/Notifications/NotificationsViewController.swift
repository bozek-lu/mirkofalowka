//
//  NotificationsViewController.swift
//  Mirkofalowka
//
//  Created by Lu on 26/05/2017.
//  Copyright © 2017 wczoraj. All rights reserved.
//

import UIKit

class NotificationViewController: UIViewController {
    let contentProvider = ContentProvider()
    
    override func viewDidLoad() {
        contentProvider.getNotifications(page: "1") { _ in
            
        }
    }
}
