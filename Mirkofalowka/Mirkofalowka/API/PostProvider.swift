//
//  PostManager.swift
//  Mirkofalowka
//
//  Created by Lu on 29/09/2016.
//  Copyright © 2016 wczoraj. All rights reserved.
//

import Foundation
import Alamofire
import AlamofireObjectMapper

class PostProvider {
//    param1
    
    func getPost(id: Int, completion: @escaping MirkoResponse) {
        
        let address = baseAPI + "entries/index/" + "\(id)" + "/appkey," + Wykop.key
        let sign = Wykop.secret + address
        let headers = ["apisign" : sign.md5()]
        //        appkey – klucz aplikacji
        //        page – strona
        
        Alamofire.request(address, headers: headers)
            .responseJSON { response in
                
//                print(response)
                
            }
            .responseObject { (response: DataResponse<MirkoPost>) in
                
                guard let arr = response.result.value else {
                    completion([])
                    return
                }
                
                completion([arr])
        }
    }
}
