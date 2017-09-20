//
//  UserProfile.swift
//  Mirkofalowka
//
//  Created by Łukasz Bożek on 29/07/2017.
//  Copyright © 2017 wczoraj. All rights reserved.
//


import Foundation
import UIKit

class UserProfile: TwitterProfileViewController {
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
        
        let _photosTableView = UITableView(frame: CGRect.zero, style: .plain)
        self.photosTableView = _photosTableView
        
        let _favoritesTableView = UITableView(frame: CGRect.zero, style: .plain)
        self.favoritesTableView = _favoritesTableView
        
        self.setupTables()
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        contentProvider.getUser(name: user) { userDict in
            self.username = userDict["login"] as? String
            self.locationString = userDict["city"] as? String
        }
        
        self.profileImage = UIImage.init(named: "icon.png")
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
extension UserProfile: UITableViewDelegate, UITableViewDataSource {
    
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
            return cell
            
        case self.photosTableView:
            let cell = tableView.dequeueReusableCell(withIdentifier: "photoCell", for: indexPath)
            cell.textLabel?.text = "Photo \(indexPath.row)"
            return cell
            
        case self.favoritesTableView:
            let cell = tableView.dequeueReusableCell(withIdentifier: "favCell", for: indexPath)
            cell.textLabel?.text = "Fav \(indexPath.row)"
            return cell
            
        default:
            return UITableViewCell()
        }
    }
}
