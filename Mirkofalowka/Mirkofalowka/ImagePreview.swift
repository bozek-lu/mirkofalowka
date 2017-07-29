//
//  ImagePreview.swift
//  Mirkofalowka
//
//  Created by Łukasz Bożek on 28/07/2017.
//  Copyright © 2017 wczoraj. All rights reserved.
//

import UIKit

enum PeekType {
    case embed
    case avatar
}

class ImagePreview: UIViewController, UIWebViewDelegate {
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    @IBOutlet weak var webView: UIWebView!
    
    var peekType = PeekType.embed
    var webSite = ""
    var user = ""
    
    override func viewDidLoad() {
        webView.loadRequest(URLRequest(url: URL(string: webSite)!))
        
        activityIndicator.startAnimating()
    }
    
    override var previewActionItems: [UIPreviewActionItem] {
        let openProfile = UIPreviewAction(title: "Otwórz profil", style: .default) { (action, viewController) -> Void in
            NotificationCenter.default.post(name: NSNotification.Name(rawValue: "openView"), object: nil, userInfo: ["view": "profile", "user": self.user])
        }
        
        let openImage = UIPreviewAction(title: "Pokaż media", style: .default) { (action, viewController) -> Void in
            NotificationCenter.default.post(name: NSNotification.Name(rawValue: "openView"), object: nil, userInfo: ["view": "safari", "webSite": self.webSite])
        }
        
        let nothing = UIPreviewAction(title: "Anuluj", style: .default) { (action, viewController) -> Void in
        }
        
        switch peekType {
        case .embed:
            return [openImage, nothing]
        case .avatar:
            return [openProfile, nothing]
        }
    }
    
    func webViewDidFinishLoad(_ webView: UIWebView) {
        activityIndicator.stopAnimating()
    }
}
