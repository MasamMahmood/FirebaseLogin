//
//  SettingViewController.swift
//  FirebaseLogin
//
//  Created by Masam Mahmood on 15.11.2019.
//  Copyright © 2019 MasamMahmood. All rights reserved.
//

import UIKit
import Firebase
import FirebaseAuth

class SettingViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    

    
    // MARK: - Button Function


    @IBAction func logOutBtn(_ sender: Any) {
        do
        {
            try Auth.auth().signOut()
            print("logOut")
            let vc = self.storyboard?.instantiateViewController(withIdentifier: "ViewController")
            self.present(vc!, animated: true, completion: nil)
        }
        catch let error as NSError
        {
            print(error.localizedDescription)
        }
    }
}
