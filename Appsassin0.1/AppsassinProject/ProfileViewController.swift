
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
//        let currentUser = PFUser.currentUser()!
//        print("Activating the game")
//        currentUser["inKuggen"] = true;
//        PFUser.currentUser()!.saveInBackground()
//        print(PFUser.currentUser()!["inKuggen"])
        // Find active, unmatched player nearby
        PFGeoPoint.geoPointForCurrentLocationInBackground {
            (geoPoint: PFGeoPoint?, error: NSError?) -> Void in
            if error == nil {
                //Send current location to Parse
                PFUser.currentUser()!["location"] = geoPoint;
                PFUser.currentUser()!.saveInBackground()
                
                //print(geoPoint)
                print(PFUser.currentUser()!.objectId!)
                
                // Create a query for places
                var query = PFUser.query()
                
                // Interested in locations near user
                query!.whereKey("location", nearGeoPoint: geoPoint!, withinKilometers: 0.05)
                
                query!.whereKey("objectId", notEqualTo:PFUser.currentUser()!.objectId!)
                
                // Limit the query to 1 people
                query!.limit = 1
                // Final list of objects
                do{
                    
                    let result = try query!.findObjects()
                    print(result[0]["username"])
                    
                    
                    
                }
                catch{
                    print(error)
                }
                
            }
            else{
                print(error)
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
       
        
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