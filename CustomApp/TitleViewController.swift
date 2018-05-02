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
    
    @IBOutlet weak var camera: UIButton!
    @IBOutlet weak var map: UIButton!
    
    @IBOutlet weak var appName: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        camera.setTitle("Camera", for: .normal)
        map.setTitle("Map", for: .normal)
        self.camera.tag = 0
        self.map.tag = 1
        appName.text = "Insert app name here"
    }
    
    @IBAction func buttonWasPressed(_ sender: UIButton) {
        if sender.tag == 0 {
            performSegue(withIdentifier: "toCamera", sender: self)
        } else if sender.tag == 1 {
            performSegue(withIdentifier: "toMap", sender: self)
        }
    }
    
    
    
    
}
