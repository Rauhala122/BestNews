//
//  ViewController.swift
//  BestNews
//
//  Created by Saska Rauhala on 19.3.2017.
//  Copyright © 2017 SarTekh. All rights reserved.
//

import UIKit

class LoginVC: UIViewController {

    @IBOutlet weak var passField: UITextField!
    @IBOutlet weak var emailField: UITextField!
    @IBOutlet weak var registerLabelBottomConst: NSLayoutConstraint!
    @IBOutlet weak var singUpView: UIView!
    @IBOutlet weak var logInView: UIView!
    @IBOutlet weak var segController: UISegmentedControl!
    
    var isRegister = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
    
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow(notification:)), name: NSNotification.Name.UIKeyboardWillShow, object: nil)
        
    }

    @IBAction func segmentedPressed(_ sender: UISegmentedControl) {
        
       isRegister = !isRegister
        
        if !isRegister {
          
            logInView.isHidden = false
            singUpView.isHidden = true
            
        } else {
            logInView.isHidden = true
            singUpView.isHidden = false
        }
        
        
        
    
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
    }
    
    
    
    

}

