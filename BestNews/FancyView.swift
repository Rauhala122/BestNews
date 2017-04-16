//
//  FancyView.swift
//  BestNews
//
//  Created by Saska Rauhala on 19.3.2017.
//  Copyright © 2017 SarTekh. All rights reserved.
//

import UIKit

class FancyView: UIView {

    override func awakeFromNib() {
        
        layer.shadowColor = UIColor.black.cgColor
        layer.shadowOpacity = 0.7
        layer.shadowOffset = CGSize.zero
        layer.shadowRadius = 5.0
        layer.cornerRadius = 3.0
        
    }

}
