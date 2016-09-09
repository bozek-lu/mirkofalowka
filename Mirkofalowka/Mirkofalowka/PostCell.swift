//
//  PostCell.swift
//  Mirkofalowka
//
//  Created by Lu on 01/09/2016.
//  Copyright © 2016 wczoraj. All rights reserved.
//

import UIKit
import SDWebImage

class PostCell: UITableViewCell {
    @IBOutlet weak var authorName: UILabel!
    @IBOutlet weak var postBody: UITextView!
    @IBOutlet weak var avatar: UIImageView!
    @IBOutlet weak var sex: UIView!
    
    func setup(post: MirkoPost) {
        let theAttributedString = try! NSAttributedString(data: post.body.dataUsingEncoding(NSUnicodeStringEncoding, allowLossyConversion: false)!,
                                                          options: [NSDocumentTypeDocumentAttribute: NSHTMLTextDocumentType],
                                                          documentAttributes: nil)
        
        
        postBody.attributedText = theAttributedString
        
        avatar.sd_setImageWithURL(NSURL(string: post.avatarURLString)!)
        authorName.text = post.author
        sex.backgroundColor = post.authorSex == .male ? UIColor.blueColor() : UIColor.pinkColor()
    }
}
