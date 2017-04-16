//
//  NewsTypesCell.swift
//  BestNews
//
//  Created by Saska Rauhala on 23.3.2017.
//  Copyright © 2017 SarTekh. All rights reserved.
//

import UIKit

class NewsTypesCell: UITableViewCell {

    @IBOutlet weak var typeName: UILabel!
 
    func configureCell(newsTypes: NewsTypes) {
        typeName.text = newsTypes.name
    }

}
