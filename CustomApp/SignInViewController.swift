//
//  SignInViewController.swift
//  CustomApp
//
//  Created by Maxson Yang on 4/23/18.
//  Copyright © 2018 wendy hua. All rights reserved.
//

import Foundation
import UIKit
import Firebase

class SigninViewController : UIViewController {
    
    
    @IBOutlet weak var username: UITextField!
    @IBOutlet weak var password: UITextField!
    
    @IBAction func signUp(_ sender: UIButton) {
        performSegue(withIdentifier: "logInToSignUp", sender: self)
    }
    
    @IBAction func signIn(_ sender: UIButton) {
        //Perform Firebase Authentication here.
        
        if username.text == nil || password.text == nil {
            print("blank username or password")
        } else {
            Auth.auth().signIn(withEmail: username.text!, password: password.text!, completion: {
                (user, error) in
                if (error == nil) {
                    self.performSegue(withIdentifier: "logInToMain", sender: self)
                } else {
                    let alert = UIAlertController(title: "Heck!", message: "Heckin account-signin failure.", preferredStyle: UIAlertControllerStyle.alert)
                    alert.addAction(UIAlertAction(title: "Bruh.", style: .default, handler: nil))
                    self.present(alert, animated: true, completion: nil)
                }
            })
        }
    }
    
    override func viewDidLoad() {
        if Auth.auth().currentUser != nil {
            performSegue(withIdentifier: "logInToMain", sender: self)
        }
    }
    
}
