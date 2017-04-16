//
//  SignUpVC.swift
//  BestNews
//
//  Created by Saska Rauhala on 20.3.2017.
//  Copyright © 2017 SarTekh. All rights reserved.
//

import UIKit
import Firebase
import FirebaseDatabase
import FirebaseAuth

class SignUpVC: UIViewController {

    @IBOutlet weak var passField: FancyField!
    @IBOutlet weak var emailField: FancyField!
    @IBOutlet weak var lastNameField: FancyField!
    @IBOutlet weak var firstNameField: FancyField!
    
    var ref: FIRDatabaseReference!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        ref = FIRDatabase.database().reference()
    
    }
    
    @IBAction func signUpPressed(_ sender: Any) {
        
        guard passField.text != "", emailField.text != "", firstNameField.text != "", lastNameField.text != "" else {
            return
        }
        
        if (passField.text?.characters.count)! > 5 {
        
        FIRAuth.auth()?.createUser(withEmail: emailField.text!, password: passField.text!, completion: { (user, error) in
            
            if user != nil {
                
            print("Account created successfully")
            
                self.ref.child("Users").child(user!.uid).setValue(["Name": "\(self.firstNameField.text!) \(self.lastNameField.text!)"])
                
             let changeRequest = FIRAuth.auth()?.currentUser?.profileChangeRequest()
             changeRequest?.displayName = "Saska Rauhala"
                
                changeRequest?.commitChanges(completion: { (error) in
                    if error != nil {
                        print(error?.localizedDescription)
                    } else {
                        print(user?.displayName!)
                        self.performSegue(withIdentifier: "goToMain", sender: nil)
                    }
                })
                
            
            
            }
            if error != nil {
                print(error?.localizedDescription)
            }
            
        })
        
        } else {
            print("Password has to be at least 6 characters long")
        }
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
    @IBAction func backToLogin(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
}
