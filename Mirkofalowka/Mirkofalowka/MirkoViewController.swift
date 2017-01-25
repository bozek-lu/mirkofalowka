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
    var selectedPost: MirkoPost?
    
    let contentProvider = ContentProvider()
    let loginProvider = LoginProvider()
    
    override func viewDidLoad() {
        tableView.rowHeight = UITableViewAutomaticDimension
        tableView.estimatedRowHeight = 60
    }
    
    override func viewDidAppear(_ animated: Bool) {
//        loginManager.connect()
        
        getPosts()
        
    }
    
    func getPosts() {
        contentProvider.micro { (posts, error) in
            self.postsArr = posts!
            self.tableView.reloadData()
            self.refreshControll.endRefreshing()
            //            self.loginManager.dummyPost()
        }
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        selectedPost = postsArr[indexPath.row]
        self.performSegue(withIdentifier: "presentPost", sender: self)
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
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let postController = segue.destination as? PostController {
            postController.post = selectedPost!
        }
    }
    
}

extension MirkoViewController: PostCellDelegate {
    func upvoteAction(on index: IndexPath) {
        print("i got index: \(index)")
    }
}
