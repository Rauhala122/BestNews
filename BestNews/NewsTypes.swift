//
//  NewsTypes.swift
//  BestNews
//
//  Created by Saska Rauhala on 23.3.2017.
//  Copyright © 2017 SarTekh. All rights reserved.
//

import Foundation

class NewsTypes {
    private var _name: String!
    
    var name: String {
        return _name
    }
    
    init(name: String) {
        _name = name
    }
}
