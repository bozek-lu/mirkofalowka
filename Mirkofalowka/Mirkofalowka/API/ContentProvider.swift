//
//  ContentManager.swift
//  Mirkofalowka
//
//  Created by Lu on 07/10/2016.
//  Copyright © 2016 wczoraj. All rights reserved.
//

import Foundation
import Alamofire

class ContentProvider {
    
    func dummyPost() {
        
        let address = baseAPI + "entries/add/appkey/" + Wykop.key + "/userkey/" + Session.shared.currentUserKey + "/"
        
        let text = "dummy entry"
        
        let parameters: [String: Any] =  ["body" : text]
        
        //        md5(SEKRET + URL + WARTOŚCI_PARAMETRÓW_POST)
        let sign = Wykop.secret + address + text
        let headers = ["apisign" : sign.md5()]
        
        Alamofire.request(address, method: .post, parameters: parameters, headers: headers)
            .responseJSON { response in
                print(response)
                
                if let json = response.result.value as? [String: Any], let err = json["error"] as? [String: Any] {
                    if let code = err["code"] as? Int, code == 11 {
                        //refresh user key
                    }
                    NotificationCenter.default.post(name: NSNotification.Name(rawValue: "youNeedLoginNotif"), object: nil, userInfo: nil)
                }
                
        }
    }
    
    func getNotifications(page: String, completion: @escaping ([Notification]) -> Void) {
//        Parametry API    userkey – klucz użytkownika
//        appkey – klucz aplikacji
//        page - strona
        let address = baseAPI + "mywykop/HashTagsNotifications/appkey/" + Wykop.key + "/userkey/" + Session.shared.currentUserKey + "/" + "page," + page
        
        //        md5(SEKRET + URL + WARTOŚCI_PARAMETRÓW_POST)
        let sign = Wykop.secret + address
        let headers = ["apisign" : sign.md5()]
        
        Alamofire.request(address, headers: headers)
            .responseJSON { response in
//                print(response)
                
                if let json = response.result.value as? [String: Any], let err = json["error"] as? [String: Any] {
                    if let code = err["code"] as? Int, code == 11 {
                        //refresh user key
                    }
                    NotificationCenter.default.post(name: NSNotification.Name(rawValue: "youNeedLoginNotif"), object: nil, userInfo: nil)
                }
                
        }
            .responseArray { (response: DataResponse<[Notification]>) in
                guard let arr = response.result.value else {
                    completion([])
                    return
                }
                
                completion(arr)
        }
        
    }
    
    func getUser(name: String, completion: ([String: Any]) -> Void) {
        let address = baseAPI + "profile/index/" + name + "/appkey," + Wykop.key
        let sign = Wykop.secret + address
        let headers = ["apisign" : sign.md5()]
        
        Alamofire.request(address, headers: headers)
            .responseJSON { response in
                
                print(response)
                
                if  let json = response.result.value as? [String: Any] {
                    completion(json)
                    let user = UserDetails(JSON: json)
                }
            }
    }
    
    
    func hot(page: Int, completion: @escaping MirkoResponse) {
        
        let address = baseAPI + "stream/hot/appkey," + Wykop.key + ",page," + "\(page)" + ",period," + Session.shared.period//",userkey," + userkey!
        
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
            .responseArray { (response: DataResponse<[MirkoPost]>) in
                
                guard let arr = response.result.value else {
                    completion([])
                    return
                }
                
                completion(arr)
        }
    }
    
    func micro(page: Int, completion: @escaping MirkoResponse) {
        
        let address = baseAPI + "stream/index/appkey," + Wykop.key + ",page," + "\(page)"
        let sign = Wykop.secret + address
        let headers = ["apisign" : sign.md5()]
        //        appkey – klucz aplikacji
        //        page – strona
        
        Alamofire.request(address, headers: headers)
            .responseJSON { response in
                
                print(response)
                
            }
            .responseArray { (response: DataResponse<[MirkoPost]>) in
                
                guard let arr = response.result.value else {
                    completion([])
                    return
                }
                
                completion(arr)
        }
    }
}
