//
//  SignInViewController.swift
//  CustomApp
//
//  Created by Maxson Yang on 4/23/18.
//  Copyright © 2018 wendy hua. All rights reserved.
//

import Foundation
import UIKit

class SigninViewController : UIViewController {
    
    
    
    @IBAction func signUp(_ sender: UIButton) {
        
        performSegue(withIdentifier: "logInToSignUp", sender: self)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
    }
    
    
    @IBAction func signIn(_ sender: UIButton) {
        //Perform Firebase Authentication here.
        
        performSegue(withIdentifier: "logInToMain", sender: self)
    
    }
    
}
