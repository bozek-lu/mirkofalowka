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
    
    var userToken: String {
        guard let key = UserDefaults.standard.string(forKey: "userToken") else {
            return ""
        }
        return key
    }
    
    var period: String {
        return UserDefaults.standard.value(forKey: "hotPeriod") as? String ?? "6"
    }
    
    func setUserToken(tok: String) {
        UserDefaults.standard.set(tok, forKey: "userToken")
    }
    
    var currentUserKey: String {
        guard let key = UserDefaults.standard.string(forKey: "currentUserToken") else {
            return ""
        }
        return key
    }
}
