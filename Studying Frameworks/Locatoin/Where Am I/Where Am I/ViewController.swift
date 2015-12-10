//
//  ViewController.swift
//  Where Am I
//
//  Created by Rob Percival on 13/03/2015.
//  Copyright (c) 2015 Appfish. All rights reserved.
//

import UIKit
import CoreLocation

class ViewController: UIViewController, CLLocationManagerDelegate {

    var manager:CLLocationManager!
    var sent = false
   
    @IBAction func resetAlert(sender: AnyObject) {
        sent = false
        print(sent)
    }
    
    @IBOutlet var latitudeLabel: UILabel!
    @IBOutlet var longitudeLabel: UILabel!
    @IBOutlet var courseLabel: UILabel!
    @IBOutlet var speedLabel: UILabel!
    @IBOutlet var altitudeLabel: UILabel!
    @IBOutlet var addressLabel: UILabel!
    @IBOutlet weak var withinKuggen: UILabel!
    
    @IBOutlet weak var distanceLabel: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        manager = CLLocationManager()
        manager.delegate = self
        manager.desiredAccuracy - kCLLocationAccuracyBest
        manager.requestWhenInUseAuthorization()
        manager.startUpdatingLocation()
        
        
    }
    
    //NOTE: [AnyObject] changed to [CLLocation]
    var inKuggen = false
    
    
     func kuggenNearby() {
        var alert = UIAlertController(title: "Hey there!", message: "Your distance to Kuggen is 50 m now!", preferredStyle: UIAlertControllerStyle.Alert)
        
        alert.addAction(UIAlertAction(title: "🤑", style: .Default, handler: { (action) -> Void in
            
            self.dismissViewControllerAnimated(true, completion: nil)
            
        }))
        
        self.presentViewController(alert, animated: true, completion: nil)
    }
    
    func locationManager(manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        
        print(locations)
        
        //userLocation - there is no need for casting, because we are now using CLLocation object

        var userLocation:CLLocation = locations[0]
        
        
        self.latitudeLabel.text = "\(userLocation.coordinate.latitude)"
        
        self.longitudeLabel.text = "\(userLocation.coordinate.longitude)"
        
        self.courseLabel.text = "\(userLocation.course)"
        
        self.speedLabel.text = "\(userLocation.speed)"
        
        self.altitudeLabel.text = "\(userLocation.altitude)"
        self.withinKuggen.text = "\(inKuggen)"
        
        
        

        
        let kuggenLat:CLLocationDegrees = 57.706673
        let kuggenLong:CLLocationDegrees = 11.938899
        let kuggenLocation:CLLocation = CLLocation(latitude:kuggenLat, longitude:kuggenLong)
        
        let distanceToKuggen = userLocation.distanceFromLocation(kuggenLocation)
        
       
        
        self.distanceLabel.text = "\(distanceToKuggen)"
        
        // send a notification
       
        
        if( distanceToKuggen < 50 )
        {
            inKuggen = true
            if( sent == false)
                {
                    print("sending msg")
                    kuggenNearby();
                    // create a corresponding local notification
//                    let notification = UILocalNotification()
//                    notification.fireDate = NSDate(timeIntervalSinceNow: 5)
//                    notification.alertBody = "Hey you! Yeah you! Swipe to unlock!"
//                    notification.alertAction = "be awesome!"
//                    notification.soundName = UILocalNotificationDefaultSoundName
//                    notification.userInfo = ["CustomField1": "w00t"]
//                    UIApplication.sharedApplication().scheduleLocalNotification(notification)
//                    
                    
                   
                    sent = true
                }
        }
        else
        {
            inKuggen = false
        }
        
        CLGeocoder().reverseGeocodeLocation(userLocation, completionHandler: { (placemarks, error) -> Void in
            
            if (error != nil) {
                
                print(error)
                
            } else {
                
                if let p = placemarks?[0] {
                    
                    var subThoroughfare:String = ""
                    
                    if (p.subThoroughfare != nil) {
                        
                        subThoroughfare = p.subThoroughfare!
                        
                    }
                    
                    self.addressLabel.text = "\(subThoroughfare) \(p.thoroughfare) \n \(p.subLocality) \n \(p.subAdministrativeArea) \n \(p.postalCode) \n \(p.country)"
                    
                }
                
                
            }
            
        })
        
        

        
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

