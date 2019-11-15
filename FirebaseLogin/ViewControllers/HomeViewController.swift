//
//  HomeViewController.swift
//  FirebaseLogin
//
//  Created by Masam Mahmood on 15.11.2019.
//  Copyright © 2019 MasamMahmood. All rights reserved.
//

import UIKit
import Firebase
import FirebaseAuth
import KeychainSwift

class HomeViewController: UIViewController {

    @IBOutlet weak var keyLbl: UILabel!
    let keychain = KeychainSwift(keyPrefix: Keys.keyPrefix)
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    

    
    // MARK: - btn logout

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
    @IBAction func getKeyBtn(_ sender: Any) {
        let data = keychain.get(Keys.userID)
        keyLbl.text = data
        
        
    }
    
}
