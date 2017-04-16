//
//  NewsCell.swift
//  BestNews
//
//  Created by Saska Rauhala on 21.3.2017.
//  Copyright © 2017 SarTekh. All rights reserved.
//

import UIKit
import Firebase
import FirebaseAuth
import FirebaseDatabase


class NewsCell: UITableViewCell {
     
    var ref: FIRDatabaseReference!
    var news: News!
    
    @IBOutlet weak var sourceLlb: UILabel!
    @IBOutlet weak var newsImage: UIImageView!
    @IBOutlet weak var newsTitle: UILabel!
    @IBOutlet weak var newsDesc: UITextView!
    
    var imageURL: String!
    var postKey: String!
    
    func configureCell(news: News) {
       
        
        imageURL = news.imageURL
        postKey = news.postKey
        
        ref = FIRDatabase.database().reference()

        newsTitle.text = news.title
        newsDesc.text = news.desc
        sourceLlb.text = news.source.uppercased()
        
        let url = URL(string: news.imageURL)!
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
    
    @IBAction func shareNews(_ sender: Any) {
    
        let user = FIRAuth.auth()?.currentUser
        
        if user != nil {
        
        let name = user?.displayName
        
        let title = self.newsTitle.text
        let desc = self.newsDesc.text
        let source = self.sourceLlb.text
        let imageURL = self.imageURL
        
        let id = NSUUID().uuidString
        
        self.ref.child("sharedNews").child(id).setValue(["title": title, "desc": desc, "source": source, "imageURL": imageURL, "user": "\(name!)"
            ])
        
        let user = FIRAuth.auth()?.currentUser
        
        self.ref.child("Users").child(user!.uid).child("sharedNews").child(self.postKey).setValue(true)
        
        } else {
            print("You have to be signed in if you want to share news")
        }
        
    }
}
