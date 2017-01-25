//
//  MirkoPost.swift
//  Mirkofalowka
//
//  Created by Lu on 28/08/2016.
//  Copyright © 2016 wczoraj. All rights reserved.
//

import Foundation
import ObjectMapper

class MirkoPost: Mappable {
    var author: String!
    var body: String!
    var id: Int!
    var date: String!
    var voteCount: Int!
    var avatarURLString: String!
    var authorSex: Sex!
    var commCount: Int!
    var postURL: String!
    var comments: [Comment]!
//    {
//    app = "<null>";
//    author = madziazpodko;
//    "author_avatar" = "http://xA.cdn03.imgwykop.pl/c3397992/madziazpodko_AuPJGFfY03,q60.jpg";
//    "author_avatar_big" = "http://xA.cdn03.imgwykop.pl/c3397992/madziazpodko_AuPJGFfY03,q150.jpg";
//    "author_avatar_lo" = "http://xA.cdn03.imgwykop.pl/c3397992/madziazpodko_AuPJGFfY03,q30.jpg";
//    "author_avatar_med" = "http://xA.cdn03.imgwykop.pl/c3397992/madziazpodko_AuPJGFfY03,q48.jpg";
//    "author_group" = 1;
//    "author_sex" = female;
//    blocked = 0;
//    body = "Hitler wiedzia\U0142 o holokau\U015bcie? #<a href=\"#pdk\">pdk</a>";
//    "can_comment" = "<null>";
//    "comment_count" = 0;
//    comments =         (
//    );
//    date = "2016-08-28 23:20:28";
//    deleted = 0;
//    embed = "<null>";
//    id = 19369839;
//    receiver = "<null>";
//    "receiver_avatar" = "<null>";
//    "receiver_avatar_big" = "<null>";
//    "receiver_avatar_lo" = "<null>";
//    "receiver_avatar_med" = "<null>";
//    "receiver_group" = "<null>";
//    "receiver_sex" = "<null>";
//    source = "<null>";
//    type = entry;
//    url = "http://www.wykop.pl/wpis/19369839/hitler-wiedzial-o-holokauscie-pdk/";
//    "user_favorite" = 0;
//    "user_vote" = 0;
//    "violation_url" = "<null>";
//    "vote_count" = 0;
//    voters =         (
//    );
//}

    required init?(map: Map) {
        
    }

    func mapping(map: Map) {
        author <- map["author"]
        body <- map["body"]
        id <- map["id"]
        date <- map["date"]
        voteCount <- map["vote_count"]
        avatarURLString <- map["author_avatar_lo"]
        postURL <- map["url"]
        commCount <- map["comment_count"]
        comments <- map["comments"]
        var authSex: String!
        authSex <- map["author_sex"]
        authorSex = authSex == Sex.male.rawValue ? .male : .female
    }
}
