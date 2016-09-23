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
//        loginManager.login()
        loginManager.connect()
    }
    
    override func viewDidAppear(_ animated: Bool) {
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
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return postsArr.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: Identifier.postCell) as! PostCell
        
        cell.setup(post: postsArr[indexPath.row], index: indexPath)
        cell.delegate = self
        return cell
    }
    
    @IBAction func refresh(sender: AnyObject) {
        getPosts()
    }
    
}

extension MirkoViewController: PostCellDelegate {
    func upvoteAction(on index: IndexPath) {
        print("i got index: \(index)")
    }
}
