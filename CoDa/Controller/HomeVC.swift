//
//  HomeVC.swift
//  CoDa
//
//  Created by kiran on 9/24/18.
//  Copyright © 2018 kiran. All rights reserved.
//

import UIKit

class HomeVC: UIViewController {

    @IBOutlet weak var nameOfPerson: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        nameOfPerson.text = UserDefaults.standard.string(forKey: "NAME")

    }

    @IBAction func logOutBtn(_ sender: Any) {
        UserDefaults.standard.set(false, forKey: "USERLOGGEDIN")
        UserDefaults.standard.set("", forKey: "NAME")
navigationController?.popToRootViewController(animated: true)    }
}
