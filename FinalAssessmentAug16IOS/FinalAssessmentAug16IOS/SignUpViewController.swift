//
//  SignUpViewController.swift
//  FinalAssessmentAug16IOS
//
//  Created by Goh Min-Yi on 20/10/2016.
//  Copyright © 2016 dragoh. All rights reserved.
//

import UIKit
import FirebaseAuth
import FirebaseDatabase

class SignUpViewController: UIViewController {

    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var emailAddressTextField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    
    @IBAction func onSignUpButtonPressed(_ sender: UIButton) {
        guard
            let email = emailAddressTextField.text,
            let password = passwordTextField.text
            else { return }
        
        FIRAuth.auth()?.createUser(withEmail: email, password: password, completion: { (user, error) in
            if let user = user {
                UserDefaults.standard.set(user.uid, forKey: "userUID")
                self.performSegue(withIdentifier: "SetUpProfileSegue", sender: nil)
                
                let firebaseRef = FIRDatabase.database().reference()
                let currentUserRef = firebaseRef.child("users").child(user.uid)
                let userDict = ["email": email]
                currentUserRef.setValue(userDict)
            } else {
                let alert = UIAlertController(title: "Sign up failed", message: error?.localizedDescription, preferredStyle: .alert)
                let dismissAction = UIAlertAction(title: "Dismiss", style: .default, handler: nil)
                alert.addAction(dismissAction)
                self.present(alert, animated: true, completion: nil)
            }
        })
    }
}
