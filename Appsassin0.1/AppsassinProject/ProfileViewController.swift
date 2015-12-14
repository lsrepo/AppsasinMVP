
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
        //Game Activated
        
        func gameStateChanger(isActive: Bool,isMatched: Bool,playerId: String){
            
            let mePlayerQuery = PFQuery(className:"Player")
            mePlayerQuery.getObjectInBackgroundWithId(playerId) {
                (mePlayer: PFObject?, error: NSError?) -> Void in
                if error == nil  {
                    //print(mePlayer!)
                    mePlayer!["isActive"] = isActive;
                    mePlayer!["isMatched"] = isMatched;
                    mePlayer!.saveInBackground()
                } else {
                    print(error)
                }
            }
        }
        let myPlayerId = PFUser.currentUser()!["player"].objectId!!
        gameStateChanger(true,isMatched: false,playerId: myPlayerId)
        
        

        
        //begin searchTarget
        func searchTarget(){
            PFGeoPoint.geoPointForCurrentLocationInBackground {
            (geoPoint: PFGeoPoint?, error: NSError?) -> Void in
                if error == nil {

                    //Send current location to Parse
                    PFUser.currentUser()!["location"] = geoPoint;
                    PFUser.currentUser()!.saveInBackground()
                    
                    //print(geoPoint)
                    //print(PFUser.currentUser()!.objectId!)
                    
                    // Create a query for places
                    let userQuery = PFUser.query()
                    
                    // Interested in locations near user
                    userQuery!.whereKey("location", nearGeoPoint: geoPoint!, withinKilometers: 0.05)
                    
                    // Exclude current user
                    userQuery!.whereKey("objectId", notEqualTo:PFUser.currentUser()!.objectId!)
                    
                    // Get players who is active and unmatched in Player class
                    userQuery!.includeKey("player");
                    let playerQuery = PFQuery(className:"Player");
                    playerQuery.whereKey("isActive",equalTo: true);
                    playerQuery.whereKey("isMatched",equalTo: false);
                    userQuery!.whereKey("player", matchesQuery: playerQuery)
                    
                    // Limit the query to 1 people
                    userQuery!.limit = 1
                    
                    // Final list of objects
                    userQuery!.findObjectsInBackgroundWithBlock {
                        (let objects: [PFObject]?, error: NSError?) -> Void in
                        if error == nil {
                            for object in objects! {
                                print( (object["username"]) , "is your target")
                            }
                        } else {
                            
                            print("Error: \(error!) \(error!.userInfo)")
                        }
                    }
            }
            else{
                print(error)
            }
        }
        
        }
        //end searchTarget()
        searchTarget()
    }
    
    
    
    //Begin getActivePlayer "backup material"
    func getActivePlayer(){
        let query = PFUser.query()
        query!.includeKey("player");
        
        // Get players who is active in Player
        let playerActiveQuery = PFQuery(className:"Player");
        playerActiveQuery.whereKey("isActive",equalTo: true);
        query!.whereKey("player", matchesQuery: playerActiveQuery)
        
        
        query!.findObjectsInBackgroundWithBlock {
            (let objects: [PFObject]?, error: NSError?) -> Void in
            
            if error == nil {
                
                for object in objects! {
                    print(object)
                }
                //                print(objects![0]["player"]["isActive"])
                
            } else {
                // Log details of the failure
                print("Error: \(error!) \(error!.userInfo)")
            }
        }
    }
    //End getActivePlayer

    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
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