//
//  ViewController.swift
//  CoDa
//
//  Created by kiran on 9/23/18.
//  Copyright © 2018 kiran. All rights reserved.
//

import UIKit
import CoreData

class ViewController: UIViewController {
    
    var users = [User]()

    @IBOutlet weak var tblView: UITableView!
    @IBOutlet weak var name: UITextField!
    @IBOutlet weak var email: UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()
        tblView.delegate =  self
        tblView.dataSource = self
        
    }
    

    @IBAction func saveBtn(_ sender: Any) {
        saveData()
    }
    
    @IBAction func showUsersBtn(_ sender: Any) {
        fetchData()
    }
    
    func saveData(){
        let name = self.name.text
        let email = self.email.text
        
       let user = User(context: PersistenceService.context)
        user.name = name
        user.email = email
        if (user.email?.isEmpty)! && (user.name?.isEmpty)!  {
            print("text field cant be empty fill  both ")
        }
        else {
            PersistenceService.saveContext()
            users.append(user)
            tblView.reloadData()
        }
    }
    
    func fetchData(){
        let fetchRequest: NSFetchRequest<User> = User.fetchRequest()
        do {
            let users = try PersistenceService.context.fetch(fetchRequest)
            self.users = users
            tblView.reloadData()
        } catch let error {
            print(error)
            
        }
    }
}

extension ViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return users.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
        cell.textLabel?.text = users[indexPath.row].name
        cell.detailTextLabel?.text = users[indexPath.row].email
        return cell
    }

}

