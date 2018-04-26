//
//  SignUpViewController.swift
//  CustomApp
//
//  Created by Maxson Yang on 4/24/18.
//  Copyright © 2018 wendy hua. All rights reserved.
//

import Foundation
import Firebase
import UIKit

class SignUpViewController : UIViewController {

    @IBOutlet weak var username : UITextField!
    @IBOutlet weak var pass : UITextField!
    @IBOutlet weak var conpass : UITextField!
    @IBOutlet weak var email : UITextField!
    
    @IBAction func signUp(_ sender: UIButton) {
        
        //Checking for blank inputs.
        if username.text == "" || pass.text == "" || conpass.text == "" || email.text == "" {
            let alert = UIAlertController(title: "Blank!", message: "Heckin blankfield in dem categories.", preferredStyle: UIAlertControllerStyle.alert)
            alert.addAction(UIAlertAction(title: "yo.", style: .default, handler: nil))
            self.present(alert, animated: true, completion: nil)
        } else {
            Auth.auth().createUser(withEmail: email.text!, password: pass.text!, completion: {
                (error, user) in
                if error == nil {
                    let alert = UIAlertController(title: "Success!", message: "You've successfully made your account!", preferredStyle: UIAlertControllerStyle.alert)
                    alert.addAction(UIAlertAction(title: "Cool.", style: .default, handler: { action in
                        self.performSegue(withIdentifier: "signUpToMain", sender: self)
                    }))
                    
                    self.present(alert, animated: true, completion: nil)
                } else {
                    let alert = UIAlertController(title: "Heck!", message: "Heckin account-make failure.", preferredStyle: UIAlertControllerStyle.alert)
                    alert.addAction(UIAlertAction(title: "Bruh.", style: .default, handler: nil))
                    self.present(alert, animated: true, completion: nil)
                }
            })
        }
    }
    
}
