//
//  EmailBodyViewController.swift
//  Email App
//
//  Created by Kamal Maged on 2020-03-02.
//  Copyright © 2020 Kamal Maged. All rights reserved.
//

import UIKit
import Firebase

class EmailBodyViewController: UIViewController {
    var email: Email?

    @IBOutlet weak var emailBody: UITextView!
    
    @IBOutlet weak var fromLabel: UILabel!
    
    @IBOutlet weak var ccLabel: UILabel!
    
    @IBOutlet weak var subjectLabel: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()
        guard let email = email else {return}
        emailBody.text = email.emailBody
        fromLabel.text = "\(email.from)"
        ccLabel.text = "\(email.cc)"
        subjectLabel.text = "\(email.subject)"
    }
    

    @IBAction func deleteButtonPressed(_ sender: Any) {
        guard let email = email else {return}
        print(Database.database().reference().child("Emails"))
    Database.database().reference().child("Emails").child("\(email.emailID)").removeValue()
    }

     @IBAction func archiveButtonPressed(_ sender: Any) {
        
     }


}
