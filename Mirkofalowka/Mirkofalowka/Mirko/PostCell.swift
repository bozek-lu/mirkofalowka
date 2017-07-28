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

class PostCell: UITableViewCell, UIViewControllerPreviewingDelegate {
    var delegate: PostCellDelegate?
    
    @IBOutlet weak var authorName: UILabel!
    @IBOutlet weak var postBody: UITextView!
    @IBOutlet weak var avatar: UIImageView!
    @IBOutlet weak var upVotes: UILabel!
    @IBOutlet weak var commentCount: UILabel!
    @IBOutlet weak var leftInset: NSLayoutConstraint!
    
    @IBOutlet weak var safariButton: UIView!
    @IBOutlet weak var postImage: UIImageView!
    @IBOutlet weak var imageContainerHeight: NSLayoutConstraint!
    
    var imageURL: URL?
    
    var cellPost: MirkoPost?
    var cellComment: Comment?
    var myIndex: IndexPath?
    
    func setup(post: MirkoPost, index: IndexPath) {
        cellPost = post
        setupAvatar(url: URL(string: post.avatarURLString)!, authorSex: post.authorSex)
        safariButton.isHidden = false
        
        let theAttributedString = try! NSAttributedString(data: post.body.data(using: String.Encoding.unicode, allowLossyConversion: false)!,
                                                          options: [NSDocumentTypeDocumentAttribute: NSHTMLTextDocumentType],
                                                          documentAttributes: nil)
        
        
        postBody.attributedText = theAttributedString
        upVotes.text = "+\(post.voteCount!)"
        if leftInset != nil {
            leftInset.constant = 2
        }
        authorName.text = post.author
        commentCount.text = "komentarzy: \(post.commCount!)"
        myIndex = index
        
        imageContainerHeight.constant = 0
        if let embed = post.embed {
            imageURL =  URL(string: embed.url)!
            
            imageContainerHeight.constant = 200
            postImage.sd_setImage(with: URL(string: embed.preview)!)
        }
        
        layoutIfNeeded()
    }
    
    
    func previewingContext(_ previewingContext: UIViewControllerPreviewing, viewControllerForLocation location: CGPoint) -> UIViewController? {
        
        let storyboard = UIStoryboard(name: "ImagePreview", bundle: nil)
        
        guard let detailViewController =
            storyboard.instantiateInitialViewController() as? ImagePreview else { return nil }
        
        if let post = cellPost {
            detailViewController.webSite = post.avatarURLString.replacingOccurrences(of: ",q60", with: "")
        } else {
            detailViewController.webSite = cellComment!.avatarURLString.replacingOccurrences(of: ",q60", with: "")
        }
        
        detailViewController.preferredContentSize =
            CGSize(width: 0.0, height: 600)
        
        previewingContext.sourceRect = avatar.frame
        
        return detailViewController
        
    }
    
    func previewingContext(_ previewingContext: UIViewControllerPreviewing, commit viewControllerToCommit: UIViewController) {
        
    }
    
    func setup(post: Comment, index: IndexPath) {
        cellComment = post
        safariButton.isHidden = true
        setupAvatar(url: URL(string: post.avatarURLString)!, authorSex: post.authorSex)
        let theAttributedString = try! NSAttributedString(data: post.body.data(using: String.Encoding.unicode, allowLossyConversion: false)!,
                                                          options: [NSDocumentTypeDocumentAttribute: NSHTMLTextDocumentType],
                                                          documentAttributes: nil)
        
        
        postBody.attributedText = theAttributedString
        upVotes.text = "+\(post.voteCount!)"
        authorName.text = post.author
        if leftInset != nil {
            leftInset.constant = 20
        }
        commentCount.text = ""
        myIndex = index
        
        imageContainerHeight.constant = 0
        if let embed = post.embed {
            imageURL =  URL(string: embed.url)!
            
            imageContainerHeight.constant = 200
            postImage.sd_setImage(with: URL(string: embed.preview)!)
        }
    }
    
    func setupAvatar(url: URL, authorSex: Sex) {
        avatar.sd_setImage(with: url)
        
        self.avatar.layer.cornerRadius = 25
        self.avatar.layer.borderWidth = 2
        self.avatar.layer.borderColor = authorSex == .male ? UIColor.blue.cgColor : UIColor.pinkColor().cgColor
    }
    @IBAction func openUserAvatar(_ sender: Any) {
        
    }
    
    @IBAction func openSafari(_ sender: Any) {
        let url = URL(string: cellPost!.postURL)
        delegate?.openSafari(with: url!)
    }
    
    @IBAction func upVoteAction(_ sender: AnyObject) {
//        print("callback with my index: \(myIndex)")
        delegate?.upvoteAction(on: myIndex!)
    }
    
    @IBAction func imageButton(_ sender: Any) {
        delegate?.openSafari(with: imageURL!)
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
    }
    
}
