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
    static let connect = "D5QZIkHdGtjehXET2kCe" //Klucz Sekret	Połącznie
}

typealias MirkoResponse = ([MirkoPost]?, NSError?) -> Void

var userkey: String?

class LoginManager {
    
    let baseAPI = "http://a.wykop.pl/"
    
    func dummyPost() {
        let address = baseAPI + "entries/add/userkey," + userkey! + ",appkey," + Wykop.key // userkey!
        
        
        let text = "dummy entry"
        
        let parameters: [String: Any] =  ["body" : text]
        
//        md5(SEKRET + URL + WARTOŚCI_PARAMETRÓW_POST)
        let sign = Wykop.secret + address + text
        let headers = ["apisign" : sign.md5()]
        
        Alamofire.request(address, parameters: parameters, headers: headers)
            .responseJSON { response in
                
                print(response)
                
        }
    }
    
    func connect() {
        
        let address = baseAPI + "user/connect/appkey," + Wykop.key
        
        Alamofire.request(address)
        .response { (defaultResponse) in
            print(defaultResponse.response)
        }
//        .response { (req, response, data, error) in
//            print(response)
//        }
//                 .responseJSON { response in
//                    print(response)
//        }
    }
    
    func login() {
        
        let address = baseAPI + "user/login/appkey," + Wykop.key
        
        let parameters =  ["accountkey" : Wykop.connect]
        
//        md5(SEKRET + URL + WARTOŚCI_PARAMETRÓW_POST)
        let sign = Wykop.secret + address + Wykop.connect
        print(sign.md5())
        let headers = ["apisign" : sign.md5()]
        
        
        Alamofire.request(address, parameters: parameters, headers: headers)
            .responseJSON { response in
                
                print(response)
                
//                userkey = response.result.value. //valueForKey("userkey") as? String
        }
    }
    
    func hot() {
        
        let address = baseAPI + "stream/hot/appkey," + Wykop.key + ",page,1,period,6"//",userkey," + userkey!
        
//        md5(SEKRET + URL + WARTOŚCI_PARAMETRÓW_POST)
        let sign = Wykop.secret + address
        let headers = ["apisign" : sign.md5()]
        
//        let parameters =  ["appkey" : Wykop.key,
//                           "page" : "1",
//                           "period" : "6"]
        
//        appkey – klucz aplikacji
//        page – strona
//        period – liczba godzin dla których mają zostać pobrane wpisy (6, 12 lub 24)
        
        Alamofire.request(address, headers: headers)
            .responseJSON { response in
                
                print(response)
                
        }
    }
    
    
    func micro(onCompletion: @escaping MirkoResponse) {
        
        let address = baseAPI + "stream/index/appkey," + Wykop.key + ",page,1"
        let sign = Wykop.secret + address
        let headers = ["apisign" : sign.md5()]
        //        appkey – klucz aplikacji
        //        page – strona
        
        Alamofire.request(address, headers: headers)
            .responseJSON { response in
                
                print(response)
                
            }
            .responseArray { (response: DataResponse<[MirkoPost]>) in
                onCompletion(response.result.value, nil)
        }
    }
}
