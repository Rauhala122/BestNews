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
    var name: String?
    var photoUrl: String?
    
    
    override func awakeFromNib() {
        FIRAuth.auth()?.addStateDidChangeListener({ (auth, user) in
            
            self.ref.child("users").child(user!.uid).observe(.value, with: { (snapshot) in
                if let dict = snapshot.value as? NSDictionary {
                    if let username = dict["username"] as? String {
                        self.name = username
                    }
                    if let imgUrl = dict["photoUrl"] as? String {
                        self.photoUrl = imgUrl
                    }
                }
            })
            
        })
    }
    
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
        
        newsImage.sd_setImage(with: URL(string: news.imageURL))  
         
        
    }
    
    @IBAction func shareNews(_ sender: Any) {
    
        let user = FIRAuth.auth()?.currentUser
        
        if user != nil {
        FIRAuth.auth()?.addStateDidChangeListener({ (auth, user) in
            
        
            
            let title = self.newsTitle.text
            let desc = self.newsDesc.text
            let source = self.sourceLlb.text
            let imageURL = self.imageURL
            
            let id = NSUUID().uuidString
            
            self.ref.child("sharedNews").child(id).setValue(["title": title, "desc": desc, "source": source, "imageURL": imageURL, "user": self.name!, "userPhotoUrl": self.photoUrl!
                ])
            
            self.ref.child("users").child(user!.uid).child("sharedNews").child(id).setValue(true)
            
            print(self.name!)
            
        })
        
        
        } else {
            print("You have to be signed in if you want to share news")
        }
        
    }
}
