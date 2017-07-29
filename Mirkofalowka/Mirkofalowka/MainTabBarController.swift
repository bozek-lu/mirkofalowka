//
//  MainTabBarController.swift
//  Mirkofalowka
//
//  Created by Lu on 25/01/2017.
//  Copyright © 2017 wczoraj. All rights reserved.
//

import UIKit
import SafariServices

class MainTabBarController: UITabBarController, UITabBarControllerDelegate {
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.delegate = self
//        019AD5
        self.tabBar.tintColor = UIColor(red: 0x01, green: 0x9A, blue: 0xD5)
        
        NotificationCenter.default.addObserver(self, selector:  #selector(self.askForLogin), name: Notification.Name("youNeedLoginNotif"), object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(self.updateBadge), name: NSNotification.Name(rawValue: Const.updateBadgeNotif), object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(self.openView), name: NSNotification.Name(rawValue: "openView"), object: nil)
    }
    
    func tabBarController(_ tabBarController: UITabBarController,
                          didSelect viewController: UIViewController) {
        
        setTabBarVisible(visible: false, animated: true)
//        if let vc = viewController as? UINavigationController {
//            vc.popViewController(animated: false);
//        }
    }
    
    func openView(notification: NSNotification) {
        let info = notification.userInfo as! Dictionary<String,AnyObject>
        
        let webSite = info["webSite"] as? String
        let view = info["view"] as? String
        let user = info["user"] as? String
        
        if view == "safari" {
            let safariVC = SFSafariViewController(url: URL(string: webSite!)!)
            self.present(safariVC, animated: true, completion: nil)
        } else {
            //profil view controller
            let strb = UIStoryboard(name: "UserProfile", bundle: nil)
            let cntrl = strb.instantiateInitialViewController() as! UserProfile
            cntrl.user = user!
            
            self.present(cntrl, animated: true, completion: nil)
        }
    }
    
    func updateBadge(notification: NSNotification) {
        let info = notification.userInfo as! Dictionary<String,AnyObject>
        
        let message = info[Const.orderValue] as! String
        
        tabBar.items?.first?.badgeValue = message
    }
    
    func askForLogin() {
        
        let presentation: UIAlertControllerStyle = UIDevice.current.userInterfaceIdiom == .pad ? .alert : .actionSheet
        var separator = "\n\n\n\n"
        
        if presentation != .actionSheet {
            separator = "\n\n\n"
        }
        
        let alert = UIAlertController(title: separator + "Mirkofalówka", message: "Czy chcesz się zalogować?", preferredStyle: presentation)
        alert.addAction(UIAlertAction(title: "Zaloguj", style: .default) {
            action in
            self.notLoggedIn()
        })
        
        let margin: CGFloat = 10.0
        var imgRect = CGRect(x: margin, y: 15, width: alert.view.bounds.size.width - margin * 4.0, height: 60)
        if presentation != .actionSheet {
            imgRect = CGRect(x: 16, y: 16, width: 238, height: 60)
        }
        
        let imageView = UIImageView(frame: imgRect)
        imageView.image = UIImage(named: "0e9")
        imageView.contentMode = .scaleAspectFit
        imageView.clipsToBounds = true
        
        alert.view.addSubview(imageView)
        
        alert.addAction(UIAlertAction(title: "Zrezygnuj", style: .cancel, handler: nil))
        
        self.present(alert, animated: true, completion: nil)
    }
    
    func notLoggedIn() {
        let storyboard = UIStoryboard(name: "Login", bundle: nil)
        
        let initialViewController = storyboard.instantiateInitialViewController()
        
        self.present(initialViewController!, animated: true, completion: nil)
    }
}

