//
//  LoginScreenViewController.swift
//  FirebaseLogin
//
//  Created by Masam Mahmood on 15.11.2019.
//  Copyright © 2019 MasamMahmood. All rights reserved.
//

import UIKit
import Firebase
import FirebaseAuth
import KeychainSwift

struct Keys {
    static let keyPrefix = "Masam"
    static let userID = "userID"
}

class LoginScreenViewController: UIViewController {

    @IBOutlet weak var emailText: UITextField!
    @IBOutlet weak var passwordText: UITextField!
    @IBOutlet weak var btnLogin: UIButton!
    
    let keychain = KeychainSwift(keyPrefix: Keys.keyPrefix)
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    

    
    // MARK: - Button Functions

    @IBAction func btnBack(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    
    @IBAction func signUpBtn(_ sender: Any) {
        let vc = self.storyboard?.instantiateViewController(withIdentifier: "SignUpViewController")
        self.present(vc!, animated: true, completion: nil)
    }
    @IBAction func loginBtn(_ sender: Any) {
        if self.emailText.text == "" || self.passwordText.text == "" {
            
            //Alert to tell the user that there was an error because they didn't fill anything in the textfields because they didn't fill anything in
            
            let alertController = UIAlertController(title: "Error", message: "Please enter an email and password.", preferredStyle: .alert)
            
            let defaultAction = UIAlertAction(title: "OK", style: .cancel, handler: nil)
            alertController.addAction(defaultAction)
            
            self.present(alertController, animated: true, completion: nil)
        
        } else {
            
            Auth.auth().signIn(withEmail: self.emailText.text!, password: self.passwordText.text!) { (user, error) in
                
                if error == nil {
                    print("You have successfully logged in")
                    
                    if let user = user {
                        let userId = user.user.uid
                        let userEmail = user.user.email 
                        print(userId)
                        print(userEmail as Any)
                        
                        if  self.keychain.set(userId, forKey: Keys.userID, withAccess: .accessibleWhenUnlocked) {
                            print("key set")
                        } else {
                            print("key not set")
                        }
                        // user.email for the email address in firebase
                        let vc = self.storyboard?.instantiateViewController(withIdentifier: "MainTabBarViewController")
                        self.present(vc!, animated: true, completion: nil)
                    }
                    
                    
                } else if let error = error, (error as NSError).code == 17011 {
                    // if user not found in Firebase.
                    let refreshAlert = UIAlertController(title: "User Not Authorised", message: "Are You Sure to LogIn Anonymous ? ", preferredStyle: UIAlertController.Style.alert)

                    refreshAlert.addAction(UIAlertAction(title: "Confirm", style: .default, handler: { (action: UIAlertAction!) in
                        self.navigationController?.popToRootViewController(animated: true)
                        print("LogIn anonymous")
                        self.anonyLogin()
                    }))

                    refreshAlert.addAction(UIAlertAction(title: "Cancel", style: .default, handler: { (action: UIAlertAction!) in
                    refreshAlert .dismiss(animated: true, completion: nil)

                    }))

                    self.present(refreshAlert, animated: true, completion: nil)
                
                } else {
                    
                    //Firebase error - email or password blank.
                    let alertController = UIAlertController(title: "Error", message: error?.localizedDescription, preferredStyle: .alert)
                    
                    let defaultAction = UIAlertAction(title: "OK", style: .cancel, handler: nil)
                    alertController.addAction(defaultAction)
                    
                    self.present(alertController, animated: true, completion: nil)
                }
            }
        }
    }

    
    func anonyLogin() {
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
    
}
