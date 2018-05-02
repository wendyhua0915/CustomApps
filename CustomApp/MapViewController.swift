//
//  MapViewController.swift
//  CustomApp
//
//  Created by wendy hua on 4/29/18.
//  Copyright © 2018 wendy hua. All rights reserved.
//

import Foundation
import UIKit
import MapKit
import Firebase

class MapViewController : UIViewController , CLLocationManagerDelegate {
    
    let viewRadius: CLLocationDistance = 1000
    static var postArray: [Post] = []
    
    @IBOutlet weak var mapView: MKMapView!
    var manager = CLLocationManager()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        if CLLocationManager.locationServicesEnabled() {
            //manager = CLLocationManager()
            manager.requestWhenInUseAuthorization()
            manager.delegate = self
            manager.desiredAccuracy = kCLLocationAccuracyBest;
            manager.distanceFilter = 500 //can change later if not updating enough
            manager.startUpdatingLocation()
            
            if (CLLocationManager.headingAvailable()) {
                manager.headingFilter = 5
                manager.startUpdatingHeading()
                
                //mapView.showsCompass = true
                print("yassss")
            } else {
                print("nooooo")
            }
            //manager.startUpdatingHeading()
            
            /*uncomment the line below for iphone use*/
            
            centerScreen(location: self.manager.location!)
            
            mapView.showsUserLocation = true
            mapView.addAnnotations(MapViewController.postArray)
            
        } else {
            print("loc services not enabled")
        }
        
    }
    
    func centerScreen(location: CLLocation) {
        let region =  MKCoordinateRegionMakeWithDistance(location.coordinate, viewRadius, viewRadius)
        mapView.setRegion(region, animated: true)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateHeading newHeading: CLHeading) {
        //gets screen to turn with you
        mapView.camera.heading = newHeading.magneticHeading
        mapView.setCamera(mapView.camera, animated: true)
    }
    
    func getPosts(completion: @escaping ([Post]?) -> Void) {
        let dbref = Database.database().reference()
        let storageRef = Storage.storage().reference()
        /*let seen = dbref.child((Auth.auth().currentUser?.displayName)!).value(forKey: "Seen")*/
        /*storageRef.child("maxsonyang").getData(maxSize: 5 * 1024 * 1024) { (data, error) in
            if let error = error {
                print(error)
            } if let data = data {
               
            } else {
                
            }
        }*/dbref.child((Auth.auth().currentUser?.displayName)!).observeSingleEvent(of: .value, with: { (snapshot) in
            if snapshot.exists() {
                if let posts = snapshot.value as? [String:AnyObject] {
                    for key in posts.keys {
                        let post = posts[key] as! [String:AnyObject]
                        let userName = post["username"] as! String
                        let imagePath = post["imagePath"] as! String
                        let latitude = post["latitude"] as! Double
                        let longitude = post["longitude"] as! Double
                        let timestamp = post["timestamp"] as! TimeInterval
                        
                        MapViewController.postArray.append(Post(lat: latitude, lon: longitude, imagepath: imagePath, id: key, timeInterval: timestamp, Username: userName))
                    }
                    completion(MapViewController.postArray)
                } else {
                    completion([])
                }
            } else {
                completion([])
            }
        })
    }
    
}
