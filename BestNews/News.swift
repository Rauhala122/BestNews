//
//  News.swift
//  BestNews
//
//  Created by Saska Rauhala on 21.3.2017.
//  Copyright © 2017 SarTekh. All rights reserved.
//

import Foundation
import Firebase

class News {
    
    private var _source: String!
    private var _author: String!
    private var _title: String!
    private var _desc: String!
    private var _URL: String!
    private var _imageURL: String!
    private var _postKey: String!
    
    var postKey: String {
        return _postKey
    }
    
    var source: String {
        
        if _source == nil {
            _source = ""
        }
        
        return _source
    }
 
    var author: String {
        if _author == nil {
            _author = ""
        }
        return _author
    }
    
    var title: String {
        if _title == nil {
            _title = ""
        }
        return _title
    }
    
    var desc: String {
        if _desc == nil {
            _desc = ""
        }
        return _desc
    }
    
    var URL: String {
        if _URL == nil {
            _URL = ""
        }
        return _URL
    }
    
    var imageURL: String {
        if _imageURL == nil {
            _imageURL = ""
        }
        return _imageURL
    }
    
    init(title: String, desc: String,imageURL: String, source: String, postKey: String) {
        _postKey = postKey
        _source = source
        _title = title
        _desc = desc
        _imageURL = imageURL
    }
    
}
