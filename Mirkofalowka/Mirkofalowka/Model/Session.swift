//
//  Session.swift
//  Mirkofalowka
//
//  Created by Lu on 07/10/2016.
//  Copyright © 2016 wczoraj. All rights reserved.
//

import Foundation

class Session {
    static let shared = Session()
    
    var userToken: String? {
        return UserDefaults.standard.string(forKey: "userToken")
    }
    
    var period = 6
    
    func setUserToken(tok: String) {
        UserDefaults.standard.set(tok, forKey: "userToken")
    }
}
