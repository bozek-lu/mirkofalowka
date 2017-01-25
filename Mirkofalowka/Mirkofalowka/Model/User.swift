//
//  User.swift
//  Mirkofalowka
//
//  Created by Lu on 28/08/2016.
//  Copyright © 2016 wczoraj. All rights reserved.
//

import Foundation
import ObjectMapper

class User: Mappable {
    var login: String!
    var about: String!
    var avatarLink: String!
    var token: String!
    
    required init?(map: Map) {
        
    }
    
    func mapping(map: Map) {
        login <- map["login"]
        about <- map["about"]
        avatarLink <- map["avatar"]
        token <- map["userkey"]
    }
}
