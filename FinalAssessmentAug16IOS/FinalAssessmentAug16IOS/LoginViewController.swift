//
//  LoginViewController.swift
//  FinalAssessmentAug16IOS
//
//  Created by Goh Min-Yi on 20/10/2016.
//  Copyright © 2016 dragoh. All rights reserved.
//

import UIKit
import FirebaseAuth

class LoginViewController: UIViewController {

    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var emailAddressTextField: UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()
    }

    @IBAction func onLoginButtonPressed(_ sender: UIButton) {
        guard
            let email = emailAddressTextField.text,
            let password = passwordTextField.text
            else { return }
        
        FIRAuth.auth()?.signIn(withEmail: email, password: password, completion: { (user, error) in
            if let user = user {
                UserDefaults.standard.set(user.uid, forKey: "userUID")
                self.performSegue(withIdentifier: "HomeSegue", sender: nil)
            } else {
                let alert = UIAlertController(title: "Sign in failed", message: error?.localizedDescription, preferredStyle: .alert)
                let dismissAction = UIAlertAction(title: "Dismiss", style: .default, handler: nil)
                alert.addAction(dismissAction)
                self.present(alert, animated: true, completion: nil)
            }
        })
    }
}
