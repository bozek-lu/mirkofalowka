//
//  MirkoViewController.swift
//  Mirkofalowka
//
//  Created by Lu on 25/08/2016.
//  Copyright © 2016 wczoraj. All rights reserved.
//

import UIKit

class MirkoViewController: UITableViewController {
    
    @IBOutlet weak var refreshControll: UIRefreshControl!
    
    var postsArr = [MirkoPost]()
    
    let loginManager = LoginManager()
    
    override func viewDidLoad() {
        tableView.rowHeight = UITableViewAutomaticDimension
        tableView.estimatedRowHeight = 60
        loginManager.login()
    }
    
    override func viewDidAppear(animated: Bool) {
//        loginManager.connect()
        
        getPosts()
        
    }
    
    func getPosts() {
        loginManager.micro { (posts, error) in
            self.postsArr = posts!
            self.tableView.reloadData()
            self.refreshControll.endRefreshing()
            //            self.loginManager.dummyPost()
        }
    }
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return postsArr.count
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier(Identifier.postCell) as! PostCell
        
        cell.setup(postsArr[indexPath.row])
        
        return cell
    }
    
    @IBAction func refresh(sender: AnyObject) {
        getPosts()
    }
    
}
