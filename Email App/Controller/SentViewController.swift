//
//  SentViewController.swift
//  Email App
//
//  Created by Kamal Maged on 2020-03-02.
//  Copyright © 2020 Kamal Maged. All rights reserved.
//

import UIKit

class SentViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    @IBOutlet weak var sentViewController: UITableView!
    var emailArray: [Email] = [Email]()
    let reuseIdentifier = "SentTableViewCell"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        sentViewController.dataSource = self
        sentViewController.delegate = self
        // Do any additional setup after loading the view.
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return emailArray.count
    }
 
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = sentViewController.dequeueReusableCell(withIdentifier: reuseIdentifier, for: indexPath) as! SentTableViewCell
        cell.toLabel.text = emailArray[indexPath.row].to
        cell.subjectLabel.text = emailArray[indexPath.row].subject
        cell.timeLabel.text = emailArray[indexPath.row].time
        
        return cell
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
