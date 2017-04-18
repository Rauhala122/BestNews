//
//  BorderView.swift
//  BestNews
//
//  Created by Saska Rauhala on 18.4.2017.
//  Copyright © 2017 SarTekh. All rights reserved.
//

import UIKit

class BorderView: UIView {

    override func awakeFromNib() {
        self.layer.borderColor = UIColor.gray.cgColor
        self.layer.borderWidth = 1
    }
    
}
