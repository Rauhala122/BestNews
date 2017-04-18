//
//  SharedNewsCell.swift
//  BestNews
//
//  Created by Saska Rauhala on 8.4.2017.
//  Copyright © 2017 SarTekh. All rights reserved.
//

import UIKit

var key: String?

class SharedNewsCell: UITableViewCell {

    @IBOutlet weak var userPhotoImage: RoundedImage!
    @IBOutlet weak var commentsButton: UIButton!
    @IBOutlet weak var user: UILabel!
    @IBOutlet weak var source: UILabel!
    @IBOutlet weak var newsImage: UIImageView!
    @IBOutlet weak var desc: UITextView!
    @IBOutlet weak var title: UILabel!
    
    func updateUI(sharedNews: SharedNews) {
     
        key = sharedNews.postKey
        user.text = sharedNews.user
        source.text = sharedNews.source.uppercased()
        desc.text = sharedNews.desc
        title.text = sharedNews.title
        userPhotoImage.image = UIImage(named: sharedNews.userPhotoUrl)
        
        userPhotoImage.sd_setImage(with: URL(string: sharedNews.userPhotoUrl))
        newsImage.sd_setImage(with: URL(string: sharedNews.imageURL))
        
        
        

        
    }

    
}
