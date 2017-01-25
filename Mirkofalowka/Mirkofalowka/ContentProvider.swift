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
