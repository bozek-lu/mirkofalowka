//
//  File.swift
//  Mirkofalowka
//
//  Created by Lu on 29/09/2016.
//  Copyright © 2016 wczoraj. All rights reserved.
//

import Foundation
import ObjectMapper

class Comment: Mappable {
    var author: String!
    var body: String!
    var id: Int!
    var date: String!
    var voteCount: Int!
    var avatarURLString: String!
    var authorSex: Sex!
    var embed: MediaModel!
    
//    app = Android;
//    author = Mysterii;
//    "author_avatar" = "http://xj.cdn02.imgwykop.pl/c3397992/Mysterii_jgJfIIGvCQ,q60.jpg";
//    "author_avatar_big" = "http://xj.cdn02.imgwykop.pl/c3397992/Mysterii_jgJfIIGvCQ,q150.jpg";
//    "author_avatar_lo" = "http://xj.cdn02.imgwykop.pl/c3397992/Mysterii_jgJfIIGvCQ,q30.jpg";
//    "author_avatar_med" = "http://xj.cdn02.imgwykop.pl/c3397992/Mysterii_jgJfIIGvCQ,q48.jpg";
//    "author_group" = 1;
//    "author_sex" = female;
//    blocked = 0;
//    body = "@<a href=\"@Chodtok\">Chodtok</a> (\U0298\U203f\U0298)";
//    date = "2016-09-29 20:04:24";
//    deleted = 0;
//    embed = "<null>";
//    "entry_id" = 19861209;
//    id = 70839023;
//    source = "<null>";
//    type = "entry_comment";
//    "user_vote" = 0;
//    "violation_url" = "<null>";
//    "vote_count" = 0;
    
    required init?(map: Map) {
        
    }
    
    func mapping(map: Map) {
        author <- map["author"]
        body <- map["body"]
        id <- map["id"]
        date <- map["date"]
        voteCount <- map["vote_count"]
        avatarURLString <- map["author_avatar_lo"]
        embed <- map["embed"]
        
        var authSex: String!
        authSex <- map["author_sex"]
        authorSex = authSex == Sex.male.rawValue ? .male : .female
    }
}
