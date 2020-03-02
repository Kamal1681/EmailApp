//
//  ComposeEmailViewController.swift
//  Email App
//
//  Created by Kamal Maged on 2020-03-02.
//  Copyright © 2020 Kamal Maged. All rights reserved.
//

import UIKit
import Firebase

class ComposeEmailViewController: UIViewController, UITextViewDelegate, UITextFieldDelegate {

    @IBOutlet weak var toLabel: UILabel!
    @IBOutlet weak var subjectLabel: UILabel!
    @IBOutlet weak var ccLabel: UILabel!
    @IBOutlet weak var emailBodyLabel: UITextView!
    
    @IBOutlet weak var subjectTextField: UITextField!
    @IBOutlet weak var ccTextField: UITextField!
    @IBOutlet weak var toTextField: UITextField!
    var email: Email?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        emailBodyLabel.delegate = self
    }
    
    
    func textViewDidEndEditing(_ textView: UITextView) {

        email?.emailBody = textView.text
    }
    
    func textView(_ textView: UITextView, shouldChangeTextIn range: NSRange, replacementText text: String) -> Bool {
        if text == "\n" {
            textView.resignFirstResponder()
            return false
        }
        return true
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        switch textField.tag {
        case 1:
            if let textFieldText = textField.text {
                email?.to = textFieldText
            }
            textField.resignFirstResponder()
        case 2:
            if let textFieldText = textField.text {
                email?.cc = textFieldText
            }
            textField.resignFirstResponder()
        case 3:
            if let textFieldText = textField.text {
                email?.subject = textFieldText
            }
            textField.resignFirstResponder()
        default:
            break
        }

        return true
    }

    @IBAction func sendButtonPressed(_ sender: Any) {
        let time = NSDate().timeIntervalSince1970
    
        let messageDB = Database.database().reference().child("Emails")
         
         let messageDictionary = ["Sender": Auth.auth().currentUser?.email,
                                  "EmailBody": emailBodyLabel.text!,
                                  "To": "\(toLabel.text!)\(toTextField.text)",
                                  "Subject": "\(subjectLabel.text!)\(subjectTextField.text)",
                                  "cc": "\(ccLabel.text!)\(ccTextField.text)",
            "Time": String(time)]
         
         messageDB.childByAutoId().setValue(messageDictionary) {
             (error, reference) in
             if error != nil {
                 print(error)
             } else {
                 print("email saved successfully")
                self.email?.emailID = reference.key!
                self.dismiss(animated: true, completion: nil)
             }
         }
    }

     @IBAction func backButtonPressed(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
     }

}
