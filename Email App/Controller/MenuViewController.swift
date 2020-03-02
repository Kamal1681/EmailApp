//
//  MenuViewController.swift
//  Email App
//
//  Created by Kamal Maged on 2020-03-02.
//  Copyright © 2020 Kamal Maged. All rights reserved.
//

import UIKit

class MenuViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet weak var menuTableview: UITableView!
    let reuseIdentifier = "MenuTableCell"
    
    var delegate: EmailViewControllerDelegate?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        menuTableview.delegate = self
        menuTableview.dataSource = self
        menuTableview.separatorStyle = .none
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 4
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = menuTableview.dequeueReusableCell(withIdentifier: reuseIdentifier, for: indexPath) as! MenuTableCell
        
        let menuOption = MenuOption(rawValue: indexPath.row)
        cell.textLabel?.text = menuOption?.description
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let menuOption = MenuOption(rawValue: indexPath.row)
        delegate?.handleMenuToggle(forMenuOption: menuOption)
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
