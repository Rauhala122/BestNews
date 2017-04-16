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
        
        let url = URL(string: sharedNews.imageURL)!
        
        DispatchQueue.global().async {
            do {
                let data = try Data(contentsOf: url)
                DispatchQueue.global().sync {
                    self.newsImage.image = UIImage(data: data)
                }
            } catch  {
                print(error)
            }
        }

        
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(true, animated: true)
    
    }
    
    
}
