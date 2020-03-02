//
//  EmailBodyViewController.swift
//  Email App
//
//  Created by Kamal Maged on 2020-03-02.
//  Copyright © 2020 Kamal Maged. All rights reserved.
//

import UIKit

class EmailBodyViewController: UIViewController {
    var email: Email?

    @IBOutlet weak var emailBody: UITextView!
    
    @IBOutlet weak var fromLabel: UILabel!
    
    @IBOutlet weak var ccLabel: UILabel!
    
    @IBOutlet weak var subjectLabel: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()
        emailBody.text = email?.emailBody
        fromLabel.text = "From: \(email?.from)"
        ccLabel.text = "cc: \(email?.cc)"
        subjectLabel.text = "Subject: \(email?.subject)"
    }
    

    @IBAction func deleteButtonPressed(_ sender: Any) {
    }

     @IBAction func archiveButtonPressed(_ sender: Any) {
     }


}