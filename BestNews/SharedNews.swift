//
//  SharedNews.swift
//  BestNews
//
//  Created by Saska Rauhala on 7.4.2017.
//  Copyright © 2017 SarTekh. All rights reserved.
//

import Foundation

class SharedNews {
    private var _postKey: String!
    private var _title: String!
    private var _desc: String!
    private var _imageURL: String!
    private var _user: String!
    private var _source: String!
    private var _userPhotoUrl: String!
    
    
    var userPhotoUrl: String {
        return _userPhotoUrl
    }
    
    var source: String {
        return _source
    }
    
    var postKey: String {
        return _postKey
    }
    
    var title: String {
        return _title
    }
    
    var desc: String {
        return _desc
    }
    
    var imageURL: String {
        return _imageURL
    }
    
    var user: String {
        return _user
    }
    
    
    init(title: String, desc: String, imageURL: String, user: String, key: String, source: String, userPhotoUrl: String) {
        
        
        _userPhotoUrl = userPhotoUrl
        _title = title
        _desc = desc
        _imageURL = imageURL
        _user = user
        _postKey = key
        _source = source
    }
  
    
}
