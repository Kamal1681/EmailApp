//
//  ArchiveViewController.swift
//  Email App
//
//  Created by Kamal Maged on 2020-03-02.
//  Copyright © 2020 Kamal Maged. All rights reserved.
//

import UIKit

class ArchiveViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    var emailArray: [Email] = [Email]()
    let reuseIdentifier = "SentTableViewCell"
    
    @IBOutlet weak var archiveTableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        archiveTableView.dataSource = self
        archiveTableView.delegate = self
        // Do any additional setup after loading the view.
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return emailArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = archiveTableView.dequeueReusableCell(withIdentifier: reuseIdentifier, for: indexPath) as! SentTableViewCell
        cell.toLabel.text = emailArray[indexPath.row].to
        cell.subjectLabel.text = emailArray[indexPath.row].subject
        cell.timeLabel.text = emailArray[indexPath.row].time
        
        return cell
    }

}
