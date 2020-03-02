//
//  LogInViewController.swift
//  Email App
//
//  Created by Kamal Maged on 2020-03-02.
//  Copyright © 2020 Kamal Maged. All rights reserved.
//

import UIKit
import Firebase

class LogInViewController: UIViewController, UITextFieldDelegate {

    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    var db: Firestore!
    
    var email: String?
    var password: String?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        passwordTextField.delegate = self
        emailTextField.delegate = self

    }
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        switch textField.tag {
        case 1:
            if let textFieldText = textField.text {
                email = textFieldText
            }
            textField.resignFirstResponder()
        case 2:
            if let textFieldText = textField.text {
                password = textFieldText
            }
            textField.resignFirstResponder()
        default:
               break
            }
        return true
    }

    @IBAction func loginButtonPressed(_ sender: Any) {
        guard let email = email,
            let password = password else {return}
        Auth.auth().signIn(withEmail: email, password: password) { (result, error) in
            if error != nil {
                print(error)
            } else {
                print("Login success")
                let container = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "ContainerController") as! ContainerController
                       UIView.animate(withDuration: 0.1, delay: 0, options: .curveEaseInOut, animations: {
                               self.view.addSubview(container.view)
                               self.addChild(container)
                               container.didMove(toParent: self)
                       }, completion: nil)
            }
        }
    }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
