//
//  PopularVC.swift
//  BestNews
//
//  Created by Saska Rauhala on 21.3.2017.
//  Copyright © 2017 SarTekh. All rights reserved.
//

import UIKit
import Firebase
import FirebaseDatabase

class PopularVC: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    var sharedNews = [SharedNews]()
    var ref: FIRDatabaseReference!
    
    var index = 0

    @IBOutlet weak var tableView: UITableView!
 
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.dataSource = self
        tableView.delegate = self

        ref = FIRDatabase.database().reference()
    
        ref.child("sharedNews").observe(.value, with: { (snapshot) in
            
            if let snapshot = snapshot.children.allObjects as? [FIRDataSnapshot] {
               
                self.sharedNews = []
                
                for snap in snapshot {
                    print("SNAP: \(snap)")
                    if let newDict = snap.value as? Dictionary<String, AnyObject> {
                        
                        var title: String?
                        var desc: String?
                        var imageURL: String?
                        var source: String?
                        
                        let key = snap.key
                        
                        if let source1 = newDict["source"] as? String {
                            source = source1
                        } else { 
                            source = ""
                        }
                        if let title1 = newDict["title"] as? String {
                            title = title1
                        } else {
                            title = ""
                        }
                        if let imageURL1 = newDict["imageURL"] as? String {
                            imageURL = imageURL1
                        } else {
                            imageURL = ""
                        }
                        if let desc1 = newDict["desc"] as? String {
                            desc = desc1
                        } else {
                            desc = ""
                        }
                        
                        let user = newDict["user"] as? String
                        
                        let new = SharedNews(title: title!, desc: desc!, imageURL: imageURL!, user: user!, key: key, source: source!)
                        
                        self.sharedNews.append(new)
                        
                    }
                }
            }
            self.tableView.reloadData()
        })
       
    }

    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return sharedNews.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: "sharedNews") as? SharedNewsCell {
            
            let sharedNew = sharedNews[indexPath.row]
            
            cell.commentsButton.tag = indexPath.row
            cell.commentsButton.addTarget(self, action: "commentVC", for: UIControlEvents.touchUpInside)
    
            
            cell.updateUI(sharedNews: sharedNew)
            
            return cell
        } else {
            return SharedNewsCell()
        }
    }
    
    
    func commentVC(sender: UIButton!) {
        
        self.performSegue(withIdentifier: "commentVC", sender: sender)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "commentVC" {
            if let destination = segue.destination as? CommentsVC {
                if let button: UIButton = sender as! UIButton? {
                    print(button.tag)
                    destination.btnTag = button.tag
                }
            }
        }
    }
    
    
        


}
