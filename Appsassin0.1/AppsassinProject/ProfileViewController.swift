
//
//  LogInViewController.swift
//  Appsassin0.1
//
//  Created by Pak on 13/12/2015.
//  Copyright © 2015 Parse. All rights reserved.
//

import UIKit
import Parse

class ProfileViewController: UIViewController {
    
    @IBAction func activateButton(sender: AnyObject) {
        self.activateGameMode();
    }
    
    func activateGameMode(){
        let currentUser = PFUser.currentUser()!
        print("Activating the game")
        currentUser["inKuggen"] = true;
        
       
        
       
        
        PFUser.currentUser()!.saveInBackground()
        print(PFUser.currentUser()!["inKuggen"])
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        
        PFGeoPoint.geoPointForCurrentLocationInBackground {
            (geoPoint: PFGeoPoint?, error: NSError?) -> Void in
            if error == nil {
                PFUser.currentUser()!["location"] = geoPoint;
                PFUser.currentUser()!.saveInBackground()
                print(geoPoint)
                
                // Create a query for places
                var query = PFUser.query()
                // Interested in locations near user.
                //query!.whereKey("location", nearGeoPoint:geoPoint!)
                query!.whereKey("location", nearGeoPoint: geoPoint!, withinKilometers: 0.05)
                
                // Limit what could be a lot of points.
                query!.limit = 2
                // Final list of objects
                do{
                    
                    let result = try query!.findObjects()
                    print(result)
                    
                }
                catch{
                    print(error)
                }
                
            }
            else{
                print(error)
            }
        }
        
        func searchPlayers(){
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
    
        if segue.identifier == "logOut" {
        PFUser.logOut()
        }
    }

}