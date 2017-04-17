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
import FirebaseStorage

class SignUpVC: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {

    @IBOutlet weak var profileImage: RoundedImage!
    @IBOutlet weak var passField: FancyField!
    @IBOutlet weak var emailField: FancyField!
    @IBOutlet weak var nameField: FancyField!
    @IBOutlet weak var usernameField: FancyField!
    
    var ref: FIRDatabaseReference!
    var stor: FIRStorageReference!
    var imagePicker: UIImagePickerController!
    
    var imageSelected = false
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        ref = FIRDatabase.database().reference()
        stor = FIRStorage.storage().reference()
        
        imagePicker = UIImagePickerController()
        imagePicker.allowsEditing = true
        imagePicker.delegate = self
        
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        if let image = info[UIImagePickerControllerEditedImage] as? UIImage {
            imageSelected = true
            profileImage.image = image
        }
        
        imagePicker.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func signUpPressed(_ sender: Any) {
        
        guard passField.text != "", emailField.text != "", nameField.text != "", usernameField.text != "" else {
            return
        }
        
        if (passField.text?.characters.count)! > 5 {
        
        FIRAuth.auth()?.createUser(withEmail: emailField.text!, password: passField.text!, completion: { (user, error) in
            
            if user != nil {
                
            print("Account created successfully")
                
                if let imgData = UIImageJPEGRepresentation(self.profileImage.image!, 0.2) {
                    
                    let imgUid = "profileImage"
                 
                    
                    self.stor.child(user!.uid).child(imgUid).put(imgData, metadata: nil, completion: { (metadata, error) in
                        if error != nil {
                            return
                        } else {
                            let imageUrl = metadata?.downloadURL()?.absoluteString
                            self.ref.child("users").child(user!.uid).setValue(["name": self.nameField.text!, "username": self.usernameField.text!, "photoUrl": imageUrl])
                        }
                    })
                }
                    
                
                    
                    
                    let changeRequest = FIRAuth.auth()?.currentUser?.profileChangeRequest()
                    changeRequest?.displayName = "\(String(describing: self.usernameField.text))"
                    
                    changeRequest?.commitChanges(completion: { (error) in
                        
                        if error != nil {
                            print(error!.localizedDescription)
                        } else {
                            print(user!.displayName!)
                            self.performSegue(withIdentifier: "goToMain", sender: nil)
                        }
                    
                    })
                    
            }

            
            if error != nil {
                print(error!.localizedDescription)
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
    
    @IBAction func imagePickerPressed(_ sender: Any) {
        
        present(imagePicker, animated: true, completion: nil)
    }
    
}
