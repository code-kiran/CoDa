//
//  ViewController.swift
//  CoDa
//
//  Created by kiran on 9/23/18.
//  Copyright © 2018 kiran. All rights reserved.
//

import UIKit
import CoreData

class LoginVC: UIViewController {
    var users = [User]()
    
    @IBOutlet weak var btnlogin: UIButton!
    @IBOutlet weak var tblView: UITableView!
    @IBOutlet weak var name: UITextField!
    @IBOutlet weak var email: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        btnlogin.backgroundColor = UIColor.lightGray
        tblView.delegate =  self
        tblView.dataSource = self
        if UserDefaults.standard.bool(forKey: "USERLOGGEDIN") == true {
            navigator(animi: false)
        } else {
            print("cannot navigate something went wrong ")
        }
    }
    
    func validateData() {
        var username = ""
        var useremail = ""
        var checkRecord = false
        for user in users {
            username = user.value(forKeyPath: "name") as! String
            useremail = user.value(forKeyPath: "email") as! String
            if username == name.text && email.text == useremail {
                checkRecord = true;
            }
        }
        if checkRecord == true {
            print("login successful")
            UserDefaults.standard.set(true, forKey: "USERLOGGEDIN")
            navigator(animi: true)
            
        } else {
            print("login unsuccessful")
        }
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(true)
        UserDefaults.standard.set(name.text, forKey: "NAME")
    }
    
    
    func navigator(animi: Bool) {
        if     let vc = storyboard?.instantiateViewController(withIdentifier: "HomeVC") as? HomeVC {
            navigationController?.pushViewController(vc, animated: animi)
        }
    }
    
    func saveData(){
        let name = self.name.text
        let email = self.email.text
        
        if name == "" || email == ""  {
            print("text field cant be empty fill  both ")
        } else {
            
            let user = User(context: PersistenceService.context)
            user.name = name
            user.email = email
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
        } catch let error {
            print(error)
            
        }
    }
    
    
    @IBAction func saveBtn(_ sender: Any) {
        saveData()
    }
    
    @IBAction func showUsersBtn(_ sender: Any) {
        fetchData()
        tblView.reloadData()
    }
    
    @IBAction func btnLogin(_ sender: Any) {
        validateData()
    }
    
  
}

extension LoginVC: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return users.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
        cell.textLabel?.text = users[indexPath.row].name
        cell.detailTextLabel?.text = users[indexPath.row].email
        return cell
    }
    
    func tableView(_ tableView: UITableView, editActionsForRowAt indexPath: IndexPath) -> [UITableViewRowAction]? {
        let deleteButton = UITableViewRowAction(style: .default, title: "Delete") { (action, indexPath) in
            self.tblView.dataSource?.tableView!(self.tblView, commit: .delete, forRowAt: indexPath)
            return
        }
        deleteButton.backgroundColor = UIColor.black
        return [deleteButton]
    }
    
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            print("Deleted")
            PersistenceService.context.delete(users[indexPath.row])
            users.remove(at: indexPath.row)
            PersistenceService.saveContext()
            tableView.reloadData()
        }
    }
    
    
}



