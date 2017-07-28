//
//  HotViewController.swift
//  Mirkofalowka
//
//  Created by Lu on 28/08/2016.
//  Copyright © 2016 wczoraj. All rights reserved.
//

import UIKit
import SafariServices

class HotViewController: UIViewController {
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var indicator: UIActivityIndicatorView!
    
    @IBOutlet weak var hotPeriod: UIBarButtonItem!
    let contentProvider = ContentProvider()
    
    var postsArr = [MirkoPost]()
    var selectedPost: MirkoPost?
    
    
    override func viewDidLoad() {
        tableView.register(UINib(nibName: String(describing: PostCell.self), bundle: nil), forCellReuseIdentifier: Identifier.postCell)
        tableView.rowHeight = UITableViewAutomaticDimension
        tableView.estimatedRowHeight = 60
        
        getPosts(page: 1)
    }
    
    override func viewDidAppear(_ animated: Bool) {
//        contentProvider.hot()
    }
    
    func getPosts(page: Int) {
        indicator.isHidden = false
        contentProvider.hot(page: page) { posts in
            self.indicator.isHidden = true
            self.postsArr.append(contentsOf: posts)
            self.tableView.reloadData()
            
        }
    }
    
    @IBAction func selectTimePeriod(_ sender: Any) {
        let alert = UIAlertController(title: "Gorące z:", message: nil, preferredStyle: .actionSheet)
        
        alert.addAction(UIAlertAction(title: "6h", style: .default , handler: { UIAlertAction in
            UserDefaults.standard.set("6", forKey: "hotPeriod")
            self.hotPeriod.title = "6h"
            self.loadAgain()
        }))
        
        alert.addAction(UIAlertAction(title: "12h", style: .default , handler: { UIAlertAction in
            UserDefaults.standard.set("12", forKey: "hotPeriod")
            
            self.hotPeriod.title = "12h"
            self.loadAgain()
        }))
        
        alert.addAction(UIAlertAction(title: "24h", style: .default , handler: { UIAlertAction in
            UserDefaults.standard.set("24", forKey: "hotPeriod")
            
            self.hotPeriod.title = "24h"
            self.loadAgain()
        }))
        
        alert.addAction(UIAlertAction(title: "Anuluj", style: .cancel, handler: nil))
        
        self.present(alert, animated: true, completion: nil)
    }
    
    func loadAgain() {
        self.postsArr = []
        self.tableView.reloadData()
        self.getPosts(page: 1)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let postController = segue.destination as? PostController {
            postController.post = selectedPost!
        }
    }
}

extension HotViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        selectedPost = postsArr[indexPath.row]
        self.performSegue(withIdentifier: "presentPost", sender: self)
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return postsArr.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
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
}


extension HotViewController: PostCellDelegate {
    func openSafari(with link: URL) {
        let safariVC = SFSafariViewController(url: link)
        self.present(safariVC, animated: true, completion: nil)
    }
    
    func upvoteAction(on index: IndexPath) {
        print("i got index: \(index)")
    }
}
