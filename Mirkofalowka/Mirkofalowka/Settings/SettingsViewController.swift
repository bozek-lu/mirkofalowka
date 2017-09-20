//
//  SettingsViewController.swift
//  Mirkofalowka
//
//  Created by Lu on 26/05/2017.
//  Copyright © 2017 wczoraj. All rights reserved.
//

import Foundation
import UIKit

class SettingsViewController: TwitterProfileViewController {
    let contentProvider = ContentProvider()
    
    var user = ""
    
    var tweetTableView: UITableView!
    var photosTableView: UITableView!
    var favoritesTableView: UITableView!
    
    var custom: UIView!
    var label: UILabel!
    
    
    override func numberOfSegments() -> Int {
        return 2
    }
    
    override func segmentTitle(forSegment index: Int) -> String {
        return "Segment \(index)"
    }
    
    override func prepareForLayout() {
        // TableViews
        let _tweetTableView = UITableView(frame: CGRect.zero, style: .plain)
        self.tweetTableView = _tweetTableView
        self.tweetTableView.backgroundColor = UIColor(red: 0x1C, green: 0x1C, blue: 0x1C)
        
        let _photosTableView = UITableView(frame: CGRect.zero, style: .plain)
        self.photosTableView = _photosTableView
        self.photosTableView.backgroundColor = UIColor(red: 0x1C, green: 0x1C, blue: 0x1C)
        
        let _favoritesTableView = UITableView(frame: CGRect.zero, style: .plain)
        self.favoritesTableView = _favoritesTableView
        self.favoritesTableView.backgroundColor = UIColor(red: 0x1C, green: 0x1C, blue: 0x1C)
        
        self.setupTables()
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        contentProvider.getUser(name: "wczoraj") { userDict in
            self.username = "@" + (userDict["login"] as? String ?? "")
            self.locationString = userDict["city"] as? String
//            self.descriptionString = ""
        }
        
        self.profileImage = UIImage.init(named: "avatar")
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.navigationController?.setNavigationBarHidden(true, animated: animated)
    }
    
    override func scrollView(forSegment index: Int) -> UIScrollView {
        switch index {
        case 0:
            return tweetTableView
        case 1:
            return photosTableView
        case 2:
            return favoritesTableView
        default:
            return tweetTableView
        }
    }
}



// MARK: UITableViewDelegates & DataSources
extension SettingsViewController: UITableViewDelegate, UITableViewDataSource {
    
    fileprivate func setupTables() {
        self.tweetTableView.delegate = self
        self.tweetTableView.dataSource = self
        self.tweetTableView.register(UITableViewCell.self, forCellReuseIdentifier: "tweetCell")
        
        self.photosTableView.delegate = self
        self.photosTableView.dataSource = self
        //self.photosTableView.isHidden = true
        self.photosTableView.register(UITableViewCell.self, forCellReuseIdentifier: "photoCell")
        
        self.favoritesTableView.delegate = self
        self.favoritesTableView.dataSource = self
        //self.favoritesTableView.isHidden = true
        self.favoritesTableView.register(UITableViewCell.self, forCellReuseIdentifier: "favCell")
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch tableView {
        case self.tweetTableView:
            return 30
        case self.photosTableView:
            return 10
        case self.favoritesTableView:
            return 0
        default:
            return 10
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch tableView {
        case self.tweetTableView:
            let cell = tableView.dequeueReusableCell(withIdentifier: "tweetCell", for: indexPath)
            cell.textLabel?.text = "Row \(indexPath.row)"
            cell.textLabel?.textColor = .white
            cell.backgroundColor = .clear
            return cell
            
        case self.photosTableView:
            let cell = tableView.dequeueReusableCell(withIdentifier: "photoCell", for: indexPath)
            cell.textLabel?.text = "Photo \(indexPath.row)"
            cell.textLabel?.textColor = .white
            cell.backgroundColor = .clear
            return cell
            
        case self.favoritesTableView:
            let cell = tableView.dequeueReusableCell(withIdentifier: "favCell", for: indexPath)
            cell.textLabel?.text = "Fav \(indexPath.row)"
            cell.textLabel?.textColor = .white
            cell.backgroundColor = .clear
            return cell
            
        default:
            return UITableViewCell()
        }
    }
}

