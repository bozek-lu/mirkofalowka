//
//  Session.swift
//  Mirkofalowka
//
//  Created by Lu on 07/10/2016.
//  Copyright © 2016 wczoraj. All rights reserved.
//

import Foundation

class Session {
    static let sharedInstance = Session()
    
    private(set) var userToken: String?
    
    func setUserToken(tok: String) {
        self.userToken = tok
    }
}
