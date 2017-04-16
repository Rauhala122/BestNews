//
//  ViewController.swift
//  BestNews
//
//  Created by Saska Rauhala on 19.3.2017.
//  Copyright © 2017 SarTekh. All rights reserved.
//

import UIKit
import Firebase

class LoginVC: UIViewController {

    @IBOutlet weak var passField: UITextField!
    @IBOutlet weak var emailField: UITextField!
    @IBOutlet weak var registerLabelBottomConst: NSLayoutConstraint!
 
    
    var isRegister = false
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
    
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow(notification:)), name: NSNotification.Name.UIKeyboardWillShow, object: nil)
        
    }

    
    func keyboardWillShow(notification: NSNotification) {
        if let info = notification.userInfo {
            let rect: CGRect = info["UIKeyboardFrameEndUserInfoKey"] as! CGRect
            
            self.view.layoutIfNeeded()
            UIView.animate(withDuration: 0.25, animations: {
                self.view.layoutIfNeeded()
                self.registerLabelBottomConst.constant = rect.height + 5
            })
        }
    }
    
    func keyboardWillHide(notification: NSNotification) {
        if let info = notification.userInfo {
            let rect: CGRect = info["UIKeyboardFrameEndUserInfoKey"] as! CGRect
            
            self.view.layoutIfNeeded()
            UIView.animate(withDuration: 0.25, animations: {
                self.view.layoutIfNeeded()
                self.registerLabelBottomConst.constant = rect.height - 200
            })
        }
    }
  
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        view.endEditing(true)
    
         NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide(notification:)), name: NSNotification.Name.UIKeyboardWillHide, object: nil)

        
    }
    
    
    @IBAction func signInPressed(_ sender: Any) {
        
        guard emailField.text != "", passField.text != "" else {
            return
        }
        
        FIRAuth.auth()?.signIn(withEmail: emailField.text!, password: passField.text!, completion: { (user, error) in
            if error != nil {
                print("SASKA: Error when signing user in")
            }
            
            if user != nil {
                print("User successfully signed in")
                self.performSegue(withIdentifier: "MainVC", sender: nil)
            }
        })
        
        
    }
    
    
    
    

}

