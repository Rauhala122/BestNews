//
//  MainVC.swift
//  BestNews
//
//  Created by Saska Rauhala on 20.3.2017.
//  Copyright © 2017 SarTekh. All rights reserved.
//

import UIKit
import Firebase
import FirebaseDatabase
import FirebaseAuth

class MainVC: UIViewController {

    @IBOutlet weak var popularView: UIView!
    @IBOutlet weak var categoryView: UIView!
    @IBOutlet weak var newsView: UIView!
    @IBOutlet weak var categoryBtn: UIButton!
    @IBOutlet weak var popularBtn: UIButton!
    @IBOutlet weak var newsBtn: UIButton!
    @IBOutlet weak var subjectBtn: UIButton!
    @IBOutlet weak var subjectView: UIView!
    
    var isNews = true
    var isCategory = false
    var isPopular = false
    var isSubject = false
    
    var ref: FIRDatabaseReference!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        ref = FIRDatabase.database().reference()
        

        newsBtn.setImage(#imageLiteral(resourceName: "News Filled-50"), for: .normal)
        
        popularView.isHidden = true
        categoryView.isHidden = true
        newsView.isHidden = false
        subjectView.isHidden = true
  

    }

    
    
    @IBAction func categoryPressed(_ sender: Any) {
        isCategory = !isCategory
        
        if isCategory {
            
            subjectView.isHidden = true
            categoryView.isHidden = false
            popularView.isHidden = true
            newsView.isHidden = true
            
            
            popularBtn.setImage(#imageLiteral(resourceName: "Very Popular Topic-50"), for: .normal)
            newsBtn.setImage(#imageLiteral(resourceName: "News-50"), for: .normal)
            isNews = false
            isPopular = false
            isSubject = false
            subjectBtn.setImage(#imageLiteral(resourceName: "Elective-50"), for: .normal)
        categoryBtn.setImage(#imageLiteral(resourceName: "Category Filled-50"), for: .normal)
        } else {
            if categoryView.isHidden == true {
            categoryBtn.setImage(#imageLiteral(resourceName: "Category-50"), for: .normal)
            }
        }
        
    }
    @IBAction func popularPressed(_ sender: Any) {
        
        isPopular = !isPopular
        
        
        if isPopular {
            
            subjectView.isHidden = true
            categoryView.isHidden = true
            popularView.isHidden = false
            newsView.isHidden = true
            
            categoryBtn.setImage(#imageLiteral(resourceName: "Category-50"), for: .normal)
            newsBtn.setImage(#imageLiteral(resourceName: "News-50"), for: .normal)
            isCategory = false
            isNews = false
            isSubject = false
            subjectBtn.setImage(#imageLiteral(resourceName: "Elective-50"), for: .normal)

            popularBtn.setImage(#imageLiteral(resourceName: "Popular Topic Filled-50"), for: .normal)
        } else {
            if popularView.isHidden == true {
            popularBtn.setImage(#imageLiteral(resourceName: "Very Popular Topic-50"), for: .normal)
        }
        }
        
    }
    @IBAction func newsPressed(_ sender: Any) {
        isNews = !isNews
        
        if isNews {
            
            subjectView.isHidden = true
            categoryView.isHidden = true
            popularView.isHidden = true
            newsView.isHidden = false
            
            popularBtn.setImage(#imageLiteral(resourceName: "Very Popular Topic-50"), for: .normal)
            categoryBtn.setImage(#imageLiteral(resourceName: "Category-50"), for: .normal)
            isPopular = false
            isCategory = false
            isSubject = false
            subjectBtn.setImage(#imageLiteral(resourceName: "Elective-50"), for: .normal)

            newsBtn.setImage(#imageLiteral(resourceName: "News Filled-50"), for: .normal)
            } else {
            if newsView.isHidden == true {
            newsBtn.setImage(#imageLiteral(resourceName: "News-50"), for: .normal)
            }
        }
        
    }
    
    @IBAction func subjectPressed(_ sender: Any) {
        
        isSubject = !isSubject
        
        if isSubject {
            
            subjectView.isHidden = false
            categoryView.isHidden = true
            popularView.isHidden = true
            newsView.isHidden = true
            
            categoryBtn.setImage(#imageLiteral(resourceName: "Category-50"), for: .normal)
            newsBtn.setImage(#imageLiteral(resourceName: "News-50"), for: .normal)
            isCategory = false
            isNews = false
            isPopular = false
            subjectBtn.setImage(#imageLiteral(resourceName: "Elective Filled-50"), for: .normal)
            popularBtn.setImage(#imageLiteral(resourceName: "Very Popular Topic-50"), for: .normal)
        } else {
            if subjectView.isHidden == true {
            subjectBtn.setImage(#imageLiteral(resourceName: "Elective-50"), for: .normal)
        }
        }
        
    }
  
    @IBAction func signOut(sender: Any) {

        if FIRAuth.auth()?.currentUser != nil {

        do {
            try! FIRAuth.auth()?.signOut()
            self.performSegue(withIdentifier: "goToLog", sender: self)
        } catch {
            print("Error when signing out user")
        }
        
        } else {
            print("You have to be signed in ")
        }
}
    
    
 
    
    
}
