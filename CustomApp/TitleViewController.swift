//
//  TitleViewController.swift
//  CustomApp
//
//  Created by Maxson Yang on 4/26/18.
//  Copyright © 2018 wendy hua. All rights reserved.
//

import Foundation
import UIKit

class TitleViewController : UIViewController {
    
    
    @IBAction func toCamera(_ sender: UIButton) {
        performSegue(withIdentifier: "toCamera", sender: self)
    }
    
    @IBAction func toPhotos(_ sender: UIButton) {
        performSegue(withIdentifier: "toPhotos", sender: self)
    }
    
    @IBAction func toSettings(_ sender: UIButton) {
        performSegue(withIdentifier: "toSettings", sender: self)
    }
    
    
}
