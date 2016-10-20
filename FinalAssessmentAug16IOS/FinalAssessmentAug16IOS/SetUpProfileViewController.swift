//
//  SetUpProfileViewController.swift
//  FinalAssessmentAug16IOS
//
//  Created by Goh Min-Yi on 20/10/2016.
//  Copyright © 2016 dragoh. All rights reserved.
//

import UIKit
import FirebaseDatabase
import FirebaseAuth

class SetUpProfileViewController: UIViewController {

    @IBOutlet weak var usernameTextField: UITextField!
    @IBOutlet weak var ageTextField: UITextField!
    @IBOutlet weak var genderTextField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }

    @IBAction func onCompleteProfileButtonPressed(_ sender: UIButton) {
        let user = FIRAuth.auth()!.currentUser!
        guard
            let username = usernameTextField.text,
            let age = ageTextField.text,
            let gender = genderTextField.text
            else
            { return }
        let profileDict = ["username": username,
                           "age": age,
                           "gender": gender]
        let profileRef = FIRDatabase.database().reference().child("profiles").child(user.uid)
        profileRef.setValue(profileDict)
        
        self.performSegue(withIdentifier: "HomeSegue", sender: nil)
    }
}
