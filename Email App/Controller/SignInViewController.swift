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
        
        password = passwordTextField.text
        nameTextField.delegate = self
        passwordTextField.delegate = self
        emailTextField.delegate = self
        
        db = Firestore.firestore()
    }

    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        switch textField.tag {
        case 1:
            if let textFieldText = textField.text {
                name = textFieldText
            }

            textField.resignFirstResponder()
        case 2:
            if let textFieldText = textField.text {
                email = textFieldText
            }
            textField.resignFirstResponder()
        case 3:
            if let textFieldText = textField.text {
                password = textFieldText
            }
            textField.resignFirstResponder()
        default:
            break
        }
        return true
    }
    
    @IBAction func resgisterButtonPressed(_ sender: Any) {
        guard let email = email,
            let password = password,
            let name = name else { return }
        
        Auth.auth().createUser(withEmail: email, password: password) { (user, error) in
            print(password)
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
        let container = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "ContainerController") as! ContainerController
                   UIView.animate(withDuration: 0.1, delay: 0, options: .curveEaseInOut, animations: {
                           self.view.addSubview(container.view)
                           self.addChild(container)
                           container.didMove(toParent: self)
                   }, completion: nil)
    }
    }


}
