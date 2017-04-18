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

    @IBOutlet weak var viewBottom: NSLayoutConstraint!
    @IBOutlet weak var tableViewBottom: NSLayoutConstraint!
    @IBOutlet weak var tableView: UITableView!

    @IBOutlet weak var commentField: UITextField!
    var ref: FIRDatabaseReference!
    var comments = [Comment]()
    var username: String?
    var userPhotUrl: String?

    var index: Int?
   
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
        
         NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow(notification:)), name: NSNotification.Name.UIKeyboardWillShow, object: nil)
        
        ref = FIRDatabase.database().reference()
        
        print("Index in comment VC \(index!)")
        
        FIRAuth.auth()?.addStateDidChangeListener({ (auth, user) in
            self.ref.child("users").child(user!.uid).observe(.value, with: { (snapshot) in
                if let dict = snapshot.value as? NSDictionary {
                    self.username = dict["username"] as? String
                    self.userPhotUrl = dict["photoUrl"] as? String
                }
            })
        })
        
        ref.child("sharedNews").child(sharedNews.postKey).child("comments").observe(.value, with: { (snapshot) in
            if let snapshot = snapshot.children.allObjects as? [FIRDataSnapshot] {
                
                self.comments = []
                
                for snap in snapshot {
                    
                    if let dict = snap.value as? NSDictionary {
                        
                        let commentText = dict["commentText"] as? String
                        let commenter = dict["commenter"] as? String
                        let userPhotoUrl = dict["userPhotoUrl"] as? String
                        
                        
                        let comment = Comment(commentText: commentText!, commenter: commenter!, userPhotoUrl: userPhotoUrl!)
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
        
        return 60
    }
    
    
    @IBAction func backPressed(_ sender: Any) {
        dismiss(animated: true) 
        
        
    }

    
    @IBAction func commentPressed(_ sender: Any) {
        
        guard commentField.text != "", (commentField.text?.characters.count)! < 300 else {
            return
        }
        
        let user = FIRAuth.auth()?.currentUser
        
        let id = NSUUID().uuidString
        
        ref.child("sharedNews").child(sharedNews.postKey).child("comments").child(id).setValue(["commentText": commentField.text, "commenter": username, "userPhotoUrl": userPhotUrl])
        ref.child("users").child(user!.uid).child("comments").child(id).setValue(true)
        commentField.text = ""
        view.endEditing(true)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide(notification:)), name: NSNotification.Name.UIKeyboardWillHide, object: nil)
        
        
    }
    
    
    
    
    func keyboardWillShow(notification: NSNotification) {
        
        if let info = notification.userInfo {
            
            let rect: CGRect = info["UIKeyboardFrameEndUserInfoKey"] as! CGRect
            
            self.view.layoutIfNeeded()
            
            UIView.animate(withDuration: 0.3, animations: { 
                self.view.layoutIfNeeded()
                self.viewBottom.constant = rect.height
                print(rect.height)
                self.tableViewBottom.constant = rect.height + 40
            })
            
            
        }
        
        
        
    }
    
    func keyboardWillHide(notification: NSNotification) {
        
        if let info = notification.userInfo {
            
            let rect: CGRect = info["UIKeyboardFrameEndUserInfoKey"] as! CGRect
            
            self.view.layoutIfNeeded()
            
            UIView.animate(withDuration: 0.3, animations: {
                self.view.layoutIfNeeded()
                self.viewBottom.constant = rect.height - 216
                self.tableViewBottom.constant = rect.height - 216 + 40
            
            })
            
            
        }
        
        
        
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        view.endEditing(true)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide(notification:)), name: NSNotification.Name.UIKeyboardWillHide, object: nil)
    }
    
    
}
