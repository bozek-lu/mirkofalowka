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
    
    var ppekType = PeekType.embed
    var webSite = ""
    
    override func viewDidLoad() {
        webView.loadRequest(URLRequest(url: URL(string: webSite)!))
        
        activityIndicator.startAnimating()
    }
    
    override var previewActionItems: [UIPreviewActionItem] {
        let openProfile = UIPreviewAction(title: "Otwórz profil", style: .default) { (action, viewController) -> Void in
            print("You liked the photo")
        }
        
        let openImage = UIPreviewAction(title: "Pokaż zdjęcie", style: .default) { (action, viewController) -> Void in
            print("You deleted the photo")
        }
        
        let nothing = UIPreviewAction(title: "Anuluj", style: .default) { (action, viewController) -> Void in
        }
        
        return [openProfile, openImage, nothing]
    }
    
    func webViewDidFinishLoad(_ webView: UIWebView) {
        activityIndicator.stopAnimating()
    }
}
