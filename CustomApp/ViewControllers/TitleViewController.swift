//
//  ViewController.swift
//  CustomApp
//
//  Created by wendy hua on 4/18/18.
//  Copyright © 2018 wendy hua. All rights reserved.
//
import Foundation
import UIKit

class TitleViewController: UIViewController {

    @IBOutlet weak var nameOfApp: UILabel!
    
    @IBOutlet weak var camera: UIButton!
    @IBOutlet weak var photos: UIButton!
    @IBOutlet weak var settings: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        nameOfApp.text = "Insert name of app here"
        settings.setTitle("Settings", for: .normal)
        photos.setTitle("Photo Album", for: .normal)
        camera.setTitle("Camera", for: .normal)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func buttonWasPressed(sender: Any) {
        switch (sender as AnyObject).tag {
        case 0:
            performSegue(withIdentifier: "toCamera", sender: self)
        case 1:
            performSegue(withIdentifier: "toPhotos", sender: self)
        case 2:
            performSegue(withIdentifier: "toSettings", sender: self)
        default:
            print("doing nothing")
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        switch segue.identifier! {
        case "toCamera":
            var nextView = segue.destination as? CameraViewController
        case "toPhotos":
            var nextView = segue.destination as? PhotosViewController
        case "toSettings":
            var nextView = segue.destination as? SettingsViewController
        default:
            print("doing nothing")
        }
    }


}

