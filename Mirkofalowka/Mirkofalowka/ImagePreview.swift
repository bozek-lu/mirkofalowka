//
//  ImagePreview.swift
//  Mirkofalowka
//
//  Created by Łukasz Bożek on 28/07/2017.
//  Copyright © 2017 wczoraj. All rights reserved.
//

import UIKit

class ImagePreview: UIViewController {
    @IBOutlet weak var webView: UIWebView!
    var webSite = ""
    
    override func viewDidLoad() {
        webView.loadRequest(URLRequest(url: URL(string: webSite)!))
    }
}
