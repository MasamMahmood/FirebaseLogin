//
//  ViewController.swift
//  FirebaseLogin
//
//  Created by Masam Mahmood on 15.11.2019.
//  Copyright © 2019 MasamMahmood. All rights reserved.
//

import UIKit
import Firebase
import FirebaseAuth
import KeychainSwift

class ViewController: UIViewController {

    let keychain = KeychainSwift(keyPrefix: Keys.keyPrefix)
    @IBOutlet weak var btnAnonymous: UIButton!
    @IBOutlet weak var btnEmail: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }

    @IBAction func anonymousLogin(_ sender: Any) {
        Auth.auth().signInAnonymously { (user, error) in
           if let error = error {
             print("LogIn failed:", error.localizedDescription)

           } else {
            print ("LogIn with uid:", user!.user.uid)
            let userId = user!.user.uid
            if  self.keychain.set(userId, forKey: Keys.userID, withAccess: .accessibleWhenUnlocked) {
                print("key set")
            } else {
                print("key not set")
            }
            let vc = self.storyboard?.instantiateViewController(withIdentifier: "MainTabBarViewController")
            self.present(vc!, animated: true, completion: nil)
           }
        }
    }
    
    @IBAction func emailLogin(_ sender: Any) {
        let vc = self.storyboard?.instantiateViewController(withIdentifier: "LoginScreenViewController")
        self.present(vc!, animated: true, completion: nil)
    }
}

