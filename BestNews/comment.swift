//
//  comment.swift
//  BestNews
//
//  Created by Saska Rauhala on 14.4.2017.
//  Copyright © 2017 SarTekh. All rights reserved.
//

import Foundation
import Firebase

class Comment {
    private var _commentText: String!
    private var _commenter: String!
    
    var commentText: String {
        return _commentText
    }
    
    var commenter: String {
        return _commenter
    }
    
    init(commentText: String, commenter: String) {
        _commentText = commentText
        _commenter = commenter
    }
    
    
}
