//
//  PostController.swift
//  Mirkofalowka
//
//  Created by Lu on 29/09/2016.
//  Copyright © 2016 wczoraj. All rights reserved.
//

import UIKit
import SafariServices


class PostController: UITableViewController {
    var post: MirkoPost? {
        didSet {
            postComments = post!.comments
        }
    }
    
    let postProvider = PostProvider()
    
    var postComments = [Comment]()
    
//    @IBAction func refresh(_ sender: AnyObject) {
//        tableView.reloadData()
//        refreshControl?.endRefreshing()
//    }
    
    override func viewDidLoad() {
        tableView.register(UINib(nibName: String(describing: PostCell.self), bundle: nil), forCellReuseIdentifier: Identifier.postCell)
        tableView.rowHeight = UITableViewAutomaticDimension
        tableView.estimatedRowHeight = 60
        
        if postComments.isEmpty {
            getPost()
        }
    }
    
    func getPost() {
        postProvider.getPost(id: post!.id) { post in
            let pst = post.first
            
            self.postComments = pst!.comments
            
            self.tableView.reloadData()
        }
    }
}

extension PostController {
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return postComments.count + 1
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.row == 0 {
            let cell = tableView.dequeueReusableCell(withIdentifier: Identifier.postCell) as! PostCell
            cell.setup(post: post!, index: indexPath)
            cell.delegate = self
            return cell
        }
        
        let cell = tableView.dequeueReusableCell(withIdentifier: Identifier.postCell) as! PostCell
        cell.setup(post: postComments[indexPath.row - 1], index: indexPath)
        cell.delegate = self
        return cell
    }
    
    
}

extension PostController: PostCellDelegate {
    func openSafari(with link: URL) {
        let safariVC = SFSafariViewController(url: link)
        self.present(safariVC, animated: true, completion: nil)
    }
    
    func upvoteAction(on index: IndexPath) {
        print("i got index: \(index)")
    }
}
