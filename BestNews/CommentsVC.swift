//
//  CommentsVC.swift
//  BestNews
//
//  Created by Saska Rauhala on 12.4.2017.
//  Copyright © 2017 SarTekh. All rights reserved.
//

import UIKit
import Firebase


class CommentsVC: UIViewController, UITableViewDelegate, UITableViewDataSource {

    @IBOutlet weak var tableView: UITableView!

    var ref: FIRDatabaseReference!
    
    var comments = [Comment]()
    private var _sharedNews: SharedNews!
    
    var sharedNews: SharedNews {
        
        get {
            return _sharedNews
        } set {
            _sharedNews = newValue
        }
    
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
        
        ref = FIRDatabase.database().reference()
        
        ref.child("sharedNews").child(sharedNews.postKey).child("comments").observe(.value, with: { (snapshot) in
            
            if let snapshot = snapshot.children.allObjects as? [FIRDataSnapshot] {
                
                for snap in snapshot {
                    
                    if let dict = snap.value as? Dictionary<String, AnyObject> {
                        
                        let commentTxt = dict["comment"] as? String
                        let commenter = dict["commenter"] as? String
                        
                        let comment = Comment(commentText: commentTxt!, commenter: commenter!)
                        self.comments.append(comment)
                        self.tableView.reloadData()
                        
                    }
                    
                    
                }
                
            }
            
        })
        

    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return comments.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: "commentsCell") as? CommentsCell {
        
            let comment = comments[indexPath.row]
            cell.updateUi(comment: comment)
            return cell
        } else {
            return CommentsCell()
        }
        
        
     
    }
    
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        let comment = comments[indexPath.row]
        
        var current = 38
        var commentTxt = comment.commentText.characters.count
        
        
        
        return 60
        
        
    }
    
    
    @IBAction func backPressed(_ sender: Any) {
        dismiss(animated: true) 
        
        
    }

    
    
}
