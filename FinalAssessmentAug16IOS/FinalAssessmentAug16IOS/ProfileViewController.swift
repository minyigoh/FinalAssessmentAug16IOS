//
//  ProfileViewController.swift
//  FinalAssessmentAug16IOS
//
//  Created by Goh Min-Yi on 20/10/2016.
//  Copyright © 2016 dragoh. All rights reserved.
//

import UIKit
import FirebaseAuth

class ProfileViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

    }

    @IBAction func onLogoutButtonPressed(_ sender: UIButton) {
        try! FIRAuth.auth()!.signOut()
        UserDefaults.standard.removeObject(forKey: "userUID")
        
        let storyboard = UIStoryboard(name: "Main", bundle: Bundle.main)
        let viewController = storyboard.instantiateViewController(withIdentifier: "LoginViewController")
        self.present(viewController, animated: true, completion: nil)
    }
    
}
