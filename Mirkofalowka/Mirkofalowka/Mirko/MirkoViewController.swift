//
//  MirkoViewController.swift
//  Mirkofalowka
//
//  Created by Lu on 25/08/2016.
//  Copyright © 2016 wczoraj. All rights reserved.
//
import SafariServices
import UIKit

class MirkoViewController: UITableViewController {
    
    @IBOutlet weak var refreshControll: UIRefreshControl!
    
    var postsArr = [MirkoPost]()
    var selectedPost: MirkoPost?
    
    let contentProvider = ContentProvider()
    let loginProvider = LoginProvider()
    
    override func viewDidLoad() {
        tableView.register(UINib(nibName: String(describing: PostCell.self), bundle: nil), forCellReuseIdentifier: Identifier.postCell)
        tableView.rowHeight = UITableViewAutomaticDimension
        tableView.estimatedRowHeight = 60
        
        getPosts(page: 1)
    }
    
    override func viewDidAppear(_ animated: Bool) {
    }
    
    @IBAction func composePost(_ sender: Any) {
        self.contentProvider.dummyPost()
    }
    
    @IBAction func refresh(_ sender: Any) {
        self.postsArr = []
        getPosts(page: 1)
    }
    
    func getPosts(page: Int) {
        contentProvider.micro(page: page) { posts in
            self.postsArr.append(contentsOf: posts)
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
        var cell = tableView.dequeueReusableCell(withIdentifier: Identifier.postCell) as? PostCell
        
        if cell == nil {
            cell = PostCell(style: .default, reuseIdentifier: Identifier.postCell)
        }
        
        if indexPath.row == postsArr.count - 1 {
            getPosts(page: Int(postsArr.count / 25) + 1)
        }
        
        if traitCollection.forceTouchCapability == .available {
            registerForPreviewing(with: cell!, sourceView: cell!.contentView)
        }
        
        cell!.setup(post: postsArr[indexPath.row], index: indexPath)
        cell!.delegate = self
        return cell!
    }
    
    @IBAction func refresh(sender: AnyObject) {
        postsArr = []
        tableView.reloadData()
        getPosts(page: 1)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let postController = segue.destination as? PostController {
            postController.post = selectedPost!
        }
    }
    
}

extension MirkoViewController: PostCellDelegate {
    func openSafari(with link: URL) {
        let safariVC = SFSafariViewController(url: link)
        self.present(safariVC, animated: true, completion: nil)
    }
    
    func upvoteAction(on index: IndexPath) {
        print("i got index: \(index)")
    }
}
