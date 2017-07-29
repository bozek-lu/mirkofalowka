//
//  LoginManager.swift
//  Mirkofalowka
//
//  Created by Lu on 25/08/2016.
//  Copyright © 2016 wczoraj. All rights reserved.
//

import Foundation
import Alamofire
import AlamofireObjectMapper
import CryptoSwift

struct Wykop {
    static let key = "8YyRIFZqDp"
    static let secret = "ThittgGhCh"
}

typealias MirkoResponse = ([MirkoPost]) -> Void
typealias LoginResponse = (Bool) -> Void

let baseAPI = "http://a.wykop.pl/"

class LoginProvider {
    
    
    func connect() {
        
        let address = baseAPI + "user/connect/appkey," + Wykop.key
        
        Alamofire.request(address)
        .response { (defaultResponse) in
            print(defaultResponse.response ?? "")
        }
//        .response { (req, response, data, error) in
//            print(response)
//        }
//                 .responseJSON { response in
//                    print(response)
//        }
    }
    
    func login(completion: @escaping LoginResponse) {
        
        let address = baseAPI + "user/login/appkey/" + Wykop.key
        
        let parameters =  ["accountkey": Session.shared.userToken, "login": "wczoraj"]
        
//        md5(SEKRET + URL + WARTOŚCI_PARAMETRÓW_POST)
        let sign = Wykop.secret + address + Session.shared.userToken + ",wczoraj"
        print(sign)
        print(sign.md5())
        let headers = ["apisign" : sign.md5()]
        
        Alamofire.request(address, method: .post, parameters: parameters, headers: headers)
            .responseJSON { response in
                
                print(response)
                guard let json = response.result.value as? [String: Any], json["error"] == nil else {
                    completion(false)
                    return
                }
                
                completion(true)
                
                UserDefaults.standard.set(json["userkey"] as! String, forKey: "currentUserToken")
        }
    }
    
    
}
