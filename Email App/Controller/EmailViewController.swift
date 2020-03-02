//
//  ViewController.swift
//  Email App
//
//  Created by Kamal Maged on 2020-03-02.
//  Copyright © 2020 Kamal Maged. All rights reserved.
//

import UIKit
import Firebase

class EmailViewController: UIViewController, UINavigationBarDelegate, UITableViewDataSource, UITableViewDelegate, UISearchBarDelegate {

    @IBOutlet weak var viewTopConstraint: NSLayoutConstraint!
    @IBOutlet weak var searchBar: UISearchBar!
    
    @IBOutlet weak var composeButton: UIButton!
    @IBOutlet weak var inboxTableView: UITableView!
    
    var delegate: EmailViewControllerDelegate?
    var email: Email?
    var emailArray: [Email] = [Email]()
    let reuseIdentifier = "EmailTableViewCell"
    override func viewDidLoad() {
        super.viewDidLoad()
        configureNavigationBar()
        viewTopConstraint.constant = (navigationController?.navigationBar.frame.size.height)!
        
        inboxTableView.delegate = self
        inboxTableView.dataSource = self
       
        getEmails()
    }
    
    func getEmails() {
        let messageDB = Database.database().reference().child("Emails")
        messageDB.observe(.childAdded) { (snapshot) in
            
            let snapshotValue = snapshot.value as! Dictionary<String,String>
            let emailBody = snapshotValue["EmailBody"]!
            let sender = snapshotValue["Sender"]!
            let subject = snapshotValue["Subject"]
            let time = snapshotValue["Time"]
            let emailID = snapshotValue["emailID"]
            
            let email = Email()
            email.emailBody = emailBody
            email.sender = sender
            email.subject = subject!
            email.time = time!
        
            self.emailArray.append(email)
            
            self.inboxTableView.reloadData()
        }
    }
    func configureNavigationBar() {
        navigationController?.setNavigationBarHidden(true, animated: false)
        let item = UINavigationItem()
        item.title = "Email App"
        item.titleView?.tintColor = .white
        item.leftBarButtonItem = UIBarButtonItem(image: #imageLiteral(resourceName: "ic_menu_white_3x").withRenderingMode(.alwaysOriginal), style: .plain, target: self, action: #selector(handleMenuToggle))
        
        
        let navigationBar = UINavigationBar()
        navigationBar.delegate = self
        navigationBar.isTranslucent = false
        navigationBar.barTintColor = UIColor(red: 71/255, green: 91/255, blue: 195/255, alpha: 1)
        navigationBar.barStyle = .black
        
        view.addSubview(navigationBar)
        navigationBar.translatesAutoresizingMaskIntoConstraints = false
        navigationBar.leftAnchor.constraint(equalTo: view.leftAnchor).isActive = true
        navigationBar.rightAnchor.constraint(equalTo: view.rightAnchor).isActive = true
        navigationBar.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor).isActive = true
        
        navigationBar.items = [item]
    }
    
    @objc func handleMenuToggle() {
        delegate?.handleMenuToggle(forMenuOption: nil)
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
       return emailArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = inboxTableView.dequeueReusableCell(withIdentifier: reuseIdentifier, for: indexPath) as! EmailTableViewCell
        cell.fromLabel.text = emailArray[indexPath.row].sender
        cell.subjectLabel.text = emailArray[indexPath.row].subject
        //cell.timeLabel.text = emailArray[indexPath.row].time
        
        return cell
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 80
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        email = emailArray[indexPath.row]
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "OpenEmailBody" {
            let emailBodyViewController = segue.destination as! EmailBodyViewController
            emailBodyViewController.email = email
        }

    }
    

}

