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
//    about = "Nie lubie - Hipokryzja (od gr. \U1f51\U03c0\U03cc\U03ba\U03c1\U03b9\U03c3\U03b9\U03c2 hypokrisis, udawanie) \U2013 fa\U0142szywo\U015b\U0107, dwulicowo\U015b\U0107, ob\U0142uda. Zachowanie lub spos\U00f3b my\U015blenia i dzia\U0142ania charakteryzuj\U0105cy si\U0119 niesp\U00f3jno\U015bci\U0105 stosowanych zasad moralnych.";
//    "author_group" = 1;
//    avatar = "http://x7.wykop.pl/cdn/c3397992/wczoraj_7ojFBAFBhL,q60.jpg";
//    "avatar_big" = "http://x7.wykop.pl/cdn/c3397992/wczoraj_7ojFBAFBhL,q150.jpg";
//    "avatar_lo" = "http://x7.wykop.pl/cdn/c3397992/wczoraj_7ojFBAFBhL,q30.jpg";
//    "avatar_med" = "http://x7.wykop.pl/cdn/c3397992/wczoraj_7ojFBAFBhL,q48.jpg";
//    buries = 82;
//    city = "";
//    comments = 21;
//    diggs = 85;
//    email = "d41d8cd98f00b204e9800998ecf8427e:1993286084";
//    entries = 142;
//    "entries_comments" = 10376;
//    followers = 12;
//    following = 7;
//    gg = "";
//    groups = 0;
//    "is_blocked" = "<null>";
//    "is_observed" = "<null>";
//    jabber = "";
//    "links_added" = 0;
//    "links_published" = 0;
//    login = wczoraj;
//    name = "";
//    "public_email" = "";
//    rank = 0;
//    "related_links" = 0;
//    sex = male;
//    "signup_date" = "2014-08-09 18:41:30";
//    url = "http://www.wykop.pl/ludzie/wczoraj/";
//    userkey = "hBclq:iyWx:6W4dv:8sYUP:fT1T4:3H3N";
//    "violation_url" = "<null>";
//    www = "";
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
