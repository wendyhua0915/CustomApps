//
//  MainARViewController.swift
//  CustomApp
//
//  Created by Maxson Yang on 5/2/18.
//  Copyright © 2018 wendy hua. All rights reserved.
//

import Foundation
import UIKit
import ARKit
import Firebase
import MapKit

class MainARViewController : UIViewController, ARSessionDelegate, CLLocationManagerDelegate {
    
    let zoop = print(Auth.auth().currentUser?.displayName)
    let userdbref = Database.database().reference().child("Users").child(UserDefaults.standard.value(forKey: "currentuser") as! String)
    let storageref = Storage.storage().reference()
    var locationFinder = CLLocationManager()
    
    @IBOutlet weak var arView: ARSCNView!
    
    @IBAction func download(_ sender: UIButton) {
        let lat = locationFinder.location?.coordinate.latitude
        let lon = locationFinder.location?.coordinate.longitude
        for post in MapViewController.postArray {
            if ((post.getlat() - 3.0).isLess(than: lat!) && lat!.isLess(than: post.getlat() + 3.0) && (post.getlon() - 3.0).isLess(than: lon!) && lon!.isLess(than: post.getlon() + 3.0)) {
                guard let currentframe = arView.session.currentFrame else {
                    return
                }
                let imageplane = SCNPlane(width: arView.bounds.width / 3000, height: arView.bounds.height / 3000)
                
                let image = storageref.child("maxsonyang/\(post.getImage)")
                imageplane.firstMaterial?.diffuse.contents = image
                imageplane.firstMaterial?.lightingModel = .constant
                let planenode = SCNNode(geometry: imageplane)
                arView.scene.rootNode.addChildNode(planenode)
                var translation = matrix_identity_float4x4
                translation.columns.3.z = -0.1
                
                planenode.simdTransform = matrix_multiply(currentframe.camera.transform, translation)
            }
        }
    }
    
    @IBAction func upload(_ sender: UIButton) {
        let image = arView.snapshot()
        var localFile = Data()
        localFile = UIImagePNGRepresentation(image)!
        let imageRef = storageref.child("maxsonyang/\(UUID().uuidString)")
        print("no bug")
        imageRef.putData(localFile, metadata: nil) { (metadata, error) in
            if let error = error {
                print(error)
                print("you fucked up")
            }
        }
        print("yes bbug")
        
        var coordinates = [String: Double]()
        coordinates["latitude"] = locationFinder.location!.coordinate.latitude
        coordinates["longitude"] = locationFinder.location!.coordinate.longitude
        //userdbref.child("bloops").child("Seen").child("maxsonyang/test").setValue(coordinates)
        var postDict = [String: AnyObject]()
        postDict["username"] = Auth.auth().currentUser?.displayName as AnyObject //this is nil
        if let a = Auth.auth().currentUser {
            print("success")
        } else {
            print("this is nil")
        }
        
        postDict["timestamp"] = ServerValue.timestamp() as AnyObject
        postDict["latitude"] = coordinates["latitude"] as AnyObject
        postDict["longitude"] = coordinates["longitude"] as AnyObject
        postDict["path"] = UUID().uuidString as AnyObject
        
        userdbref.child("Seen").childByAutoId().setValue(postDict)
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        setupARView()
    }
    
    func setupARView() {
        let config = ARWorldTrackingConfiguration()
        if #available(iOS 11.3, *) {
            config.planeDetection = [.vertical, .horizontal]
        } else {
            // Fallback on earlier versions
        }
        arView.session.run(config, options: [])
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(true)
        locationFinder.requestWhenInUseAuthorization()
        locationFinder.delegate = self
        locationFinder.desiredAccuracy = kCLLocationAccuracyBest
        locationFinder.distanceFilter = 500
        locationFinder.startUpdatingLocation()
    }
    
}
