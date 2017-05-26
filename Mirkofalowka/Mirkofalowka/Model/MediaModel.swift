//
//  MediaModel.swift
//  Mirkofalowka
//
//  Created by Lu on 26/05/2017.
//  Copyright © 2017 wczoraj. All rights reserved.
//


enum MediaType: String {
    case video
    case image
    case none
    
    init(type: String?) {
        guard let str = type, let initialized = MediaType(rawValue: str) else {
            self = .none
            return
        }
        
        self = initialized
    }
}

import Foundation
import ObjectMapper

class MediaModel: Mappable {
    var preview: String!
    var source: String!
    var typeStr: String!
    var url: String!
    
    var type: MediaType = .none
    
    required init?(map: Map) {
        
    }
    
    func mapping(map: Map) {
        preview <- map["preview"]
        source <- map["source"]
        typeStr <- map["typeStr"]
        url <- map["url"]
        
        type = MediaType(type: typeStr)
    }
}
