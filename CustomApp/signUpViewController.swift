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
    
    var ref = Database.database().reference()
    
    @IBAction func signUp(_ sender: UIButton) {
        //Checking for blank inputs.
        if username.text == "" || pass.text == "" || conpass.text == "" || email.text == "" {
            let alert = UIAlertController(title: "Blank!", message: "Heckin blankfield in dem categories.", preferredStyle: UIAlertControllerStyle.alert)
            alert.addAction(UIAlertAction(title: "yo.", style: .default, handler: nil))
            self.present(alert, animated: true, completion: nil)
        } else {
            Auth.auth().createUser(withEmail: username.text!, password: pass.text!, completion: {
                (user, error) in
                if error == nil {
                    print("no problem")
                    let changeReq = user!.createProfileChangeRequest()
                    changeReq.displayName = self.username.text
                    changeReq.commitChanges(completion:
                        { (err) in
                    })
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
    
    func registerUser(username : String) {
        let newuser = ref.child("Users").child(username)
        newuser.child("Friends").setValue(["Example Friend" : 0])
        newuser.child("bloops").child("Seen").setValue(["BloopName" : 0])
        newuser.child("bloops").child("Unseen").setValue(["BloopName" : 0])
    }
    
}
