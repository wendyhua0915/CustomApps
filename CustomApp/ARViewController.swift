//
//  ARViewController.swift
//  CustomApp
//
//  Created by Maxson Yang on 4/29/18.
//  Copyright © 2018 wendy hua. All rights reserved.
//

import Foundation
import ARKit
import UIKit

class ARViewController : UIViewController, ARSessionDelegate{
    
    var shipnode : SCNNode!
    
    @IBOutlet weak var arScene: ARSCNView!
    @IBOutlet weak var DataLabel: UILabel!
    @IBOutlet weak var getinfo: UITextField!
    
    //testing for relocationing.
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        let config = ARWorldTrackingConfiguration()
        if #available(iOS 11.3, *) {
            config.planeDetection = [.horizontal, .vertical]
        } else {
            // Fallback on earlier versions
        }
        arScene.session.delegate = self
        arScene.session.run(config, options: [])
        
        let tapper = UITapGestureRecognizer(target: self, action: #selector(ARViewController.pauseDat))
        self.view.addGestureRecognizer(tapper)
        
        let tester = UserDefaults.standard
        
    }
    
    
    func printInfo() {
        view.endEditing(true)
        let ting = arScene.session.currentFrame?.camera.transform
        DataLabel.text = ting![Int(getinfo.text!)!].debugDescription
    }
    
    @objc func pauseDat() {
        scrnshat()
        //virtualvideo()
        printInfo()
        
    }
    
    func scrnshat() {
        guard let currentframe = arScene.session.currentFrame else {
            return
        }
        
        let imageplane = SCNPlane(width: arScene.bounds.width / 3000, height: arScene.bounds.height / 3000)
        imageplane.firstMaterial?.diffuse.contents = arScene.snapshot()
        imageplane.firstMaterial?.lightingModel = .constant
        let planenode = SCNNode(geometry: imageplane)
        arScene.scene.rootNode.addChildNode(planenode)
        
        var translation = matrix_identity_float4x4
        translation.columns.3.z = -0.1
        planenode.simdTransform = matrix_multiply(currentframe.camera.transform, translation)
    }
    
    func virtualvideo() {
        guard let currentframe = arScene.session.currentFrame else {
            return
        }
        
        let videonode = SKVideoNode(fileNamed: "IMG_1713.MOV")
        videonode.play()
        
        let skScene = SKScene(size: CGSize(width: 480, height: 600))
        skScene.addChild(videonode)
        
        videonode.position = CGPoint(x: skScene.size.width / 2, y: skScene.size.height / 2)
        videonode.size = skScene.size
        
        let tvPlanet = SCNPlane(width: 0.75, height: 1.0)
        tvPlanet.firstMaterial?.diffuse.contents = skScene
        tvPlanet.firstMaterial?.isDoubleSided = true
        
        let tvPlanetNode = SCNNode(geometry: tvPlanet)
        var translation = matrix_identity_float4x4
        translation.columns.3.z = -0.1
        tvPlanetNode.simdTransform = matrix_multiply(currentframe.camera.transform, translation)
        arScene.scene.rootNode.addChildNode(tvPlanetNode)
        
    }
    
    func dropAnchor() {
        guard let currentframe = arScene.session.currentFrame else {
            return
        }
        
        let imageplane = SCNPlane(width: arScene.bounds.width / 3000, height: arScene.bounds.height / 3000)
        imageplane.firstMaterial?.diffuse.contents = arScene.snapshot()
        imageplane.firstMaterial?.lightingModel = .constant
        let planenode = SCNNode(geometry: imageplane)
        arScene.scene.rootNode.addChildNode(planenode)
        
        var translation = matrix_identity_float4x4
        translation.columns.3.z = -0.1
        planenode.simdTransform = matrix_multiply(currentframe.camera.transform, translation)
        
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(true)
        let ting = arScene.session.currentFrame?.camera.transform
    }
    
}
