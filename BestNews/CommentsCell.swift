//
//  CommentsCell.swift
//  BestNews
//
//  Created by Saska Rauhala on 16.4.2017.
//  Copyright © 2017 SarTekh. All rights reserved.
//

import UIKit

class CommentsCell: UITableViewCell {

    @IBOutlet weak var userImage: RoundedImage!
    @IBOutlet weak var commenterLbl: UILabel!
    @IBOutlet weak var commentLbl: UITextView!
  
    func updateUi(comment: Comment) {
        
        commenterLbl.text = comment.commenter
        commentLbl.text = comment.commentText
        userImage.sd_setImage(with: URL(string: comment.userPhotoUrl))
        
        
    }
    
}
