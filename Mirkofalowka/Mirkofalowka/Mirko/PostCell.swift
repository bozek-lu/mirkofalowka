//
//  PostCell.swift
//  Mirkofalowka
//
//  Created by Lu on 01/09/2016.
//  Copyright © 2016 wczoraj. All rights reserved.
//

import UIKit
import SDWebImage

protocol PostCellDelegate {
    func upvoteAction(on index: IndexPath)
    func openSafari(with link: URL)
}

class PostCell: UITableViewCell {
    
    var delegate: PostCellDelegate?
    
    @IBOutlet weak var authorName: UILabel!
    @IBOutlet weak var postBody: UITextView!
    @IBOutlet weak var avatar: UIImageView!
    @IBOutlet weak var sex: UIView!
    @IBOutlet weak var upVotes: UILabel!
    @IBOutlet weak var commentCount: UILabel!
    @IBOutlet weak var leftInset: NSLayoutConstraint!
    
    @IBOutlet weak var safariButton: UIView!
    
    var cellPost: MirkoPost?
    var myIndex: IndexPath?
    
    func setup(post: MirkoPost, index: IndexPath) {
        cellPost = post
        
//        safariButton.isHidden = false
        
        let theAttributedString = try! NSAttributedString(data: post.body.data(using: String.Encoding.unicode, allowLossyConversion: false)!,
                                                          options: [NSDocumentTypeDocumentAttribute: NSHTMLTextDocumentType],
                                                          documentAttributes: nil)
        
        
        postBody.attributedText = theAttributedString
        upVotes.text = "+\(post.voteCount!)"
        avatar.sd_setImage(with: NSURL(string: post.avatarURLString)! as URL!)
        authorName.text = post.author
        sex.backgroundColor = post.authorSex == .male ? UIColor.blue : UIColor.pinkColor()
        commentCount.text = "komentarzy: \(post.commCount!)"
        myIndex = index
    }
    
    func setup(post: Comment, index: IndexPath) {
//        safariButton.isHidden = false
        let theAttributedString = try! NSAttributedString(data: post.body.data(using: String.Encoding.unicode, allowLossyConversion: false)!,
                                                          options: [NSDocumentTypeDocumentAttribute: NSHTMLTextDocumentType],
                                                          documentAttributes: nil)
        
        
        postBody.attributedText = theAttributedString
        upVotes.text = "+\(post.voteCount!)"
        avatar.sd_setImage(with: NSURL(string: post.avatarURLString)! as URL!)
        authorName.text = post.author
        sex.backgroundColor = post.authorSex == .male ? UIColor.blue : UIColor.pinkColor()
        leftInset.constant = 20
        commentCount.text = ""
        myIndex = index
    }
    
    @IBAction func openSafari(_ sender: Any) {
        let url = URL(string: cellPost!.postURL)
        delegate?.openSafari(with: url!)
    }
    
    @IBAction func upVoteAction(_ sender: AnyObject) {
        print("callback with my index: \(myIndex)")
        delegate?.upvoteAction(on: myIndex!)
    }
    
}
