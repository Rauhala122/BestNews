//
//  FancyField.swift
//  BestNews
//
//  Created by Saska Rauhala on 19.3.2017.
//  Copyright © 2017 SarTekh. All rights reserved.
//

import UIKit

class FancyField: UITextField {

    override func awakeFromNib() {
        layer.borderColor = UIColor.gray.cgColor
        layer.borderWidth = 1.0
        layer.cornerRadius = 3.0
        layer.backgroundColor = UIColor.white.cgColor
    }

}
