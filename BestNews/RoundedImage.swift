//
//  RoundedImage.swift
//  BestNews
//
//  Created by Saska Rauhala on 17.4.2017.
//  Copyright © 2017 SarTekh. All rights reserved.
//

import UIKit

class RoundedImage: UIImageView {

    override func awakeFromNib() {
        self.layer.cornerRadius = self.frame.width / 2
        self.clipsToBounds = true
    }

}
