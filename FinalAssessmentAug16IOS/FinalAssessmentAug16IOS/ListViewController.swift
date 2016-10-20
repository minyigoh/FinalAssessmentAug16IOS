//
//  ListViewController.swift
//  FinalAssessmentAug16IOS
//
//  Created by Goh Min-Yi on 20/10/2016.
//  Copyright © 2016 dragoh. All rights reserved.
//

import UIKit

class ListViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    var matchedProfiles = [Profile]()
    
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return matchedProfiles.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell")!
        let profile = matchedProfiles[indexPath.row]
        cell.textLabel?.text = profile.username
        cell.detailTextLabel?.text = String(describing: profile.age)
        return cell
    }

}
