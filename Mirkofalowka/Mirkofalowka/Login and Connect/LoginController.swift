//
//  LoginController.swift
//  Mirkofalowka
//
//  Created by Lu on 07/10/2016.
//  Copyright © 2016 wczoraj. All rights reserved.
//

import UIKit

class LoginController: UIViewController {
    
    let loginProvider = LoginProvider()
    
    @IBOutlet weak var webView: UIWebView!
    
    
    override func viewDidLoad() {
    }
    
    override func viewDidAppear(_ animated: Bool) {
        
        let address = baseAPI + "user/connect/appkey," + Wykop.key
        webView.loadRequest(URLRequest(url: URL(string: address)!))
    }
    
    func login() {
        loginProvider.login() { success in
//            self.performSegue(withIdentifier: "mainView", sender: self)
            self.dismiss(animated: true, completion: nil)
        }
        
    }
}

extension LoginController : UIWebViewDelegate {
    
    func webView(_ webView: UIWebView, shouldStartLoadWith request: URLRequest, navigationType: UIWebViewNavigationType) -> Bool {
        
//        print(request)
        
        let urlString = request.url?.absoluteString
        
        if urlString!.contains("ConnectSuccess") {
            let parts = urlString?.components(separatedBy: "/")
            let tok = parts![parts!.count - 2]
            
            Session.shared.setUserToken(tok: tok)
            
            login()
        }
        
        return true
    }
}
