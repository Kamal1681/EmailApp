//
//  SignInViewController.swift
//  Email App
//
//  Created by Kamal Maged on 2020-03-02.
//  Copyright © 2020 Kamal Maged. All rights reserved.
//

import UIKit
import Firebase

class SignInViewController: UIViewController, UITextFieldDelegate {

    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var emailTextField: UITextField!
    var db: Firestore!
    
    var email: String?
    var password: String?
    var name: String?
    override func viewDidLoad() {
        super.viewDidLoad()
        email = emailTextField.text
        password = passwordTextField.text
        name = nameTextField.text
        db = Firestore.firestore()
    }


    @IBAction func resgisterButtonPressed(_ sender: Any) {
        guard let email = email,
            let password = password,
            let name = name else { return }
        
        Auth.auth().createUser(withEmail: email, password: password) { (user, error) in
            if error != nil {
                print(error)
            } else {
                print("Registration successful")

            }
            Auth.auth().signIn(withEmail: email, password: password) { (authDataResult, error) in
                if authDataResult != nil {
                    let user = Auth.auth().currentUser
                    if user != nil {
                        self.db.collection("users").document(user!.uid).setData([ "uid": user!.uid,
                            "name": name], merge: true) { err in
                            if let err = err {
                                print("Error writing document: \(err)")
                            } else {
                                print("Additional user information successfully written in Firebase!")
                            }
                    }
                }
            }
        }
    }
    }


}
