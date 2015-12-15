
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
    
    @IBAction func reactivateAllButton(sender: AnyObject) {
        self.reactivateAll();
    }
    @IBAction func activateButton(sender: AnyObject) {
        self.activateGameMode();
    }
    
    @IBAction func searchPlayerButton(sender: AnyObject) {
        self.searchPlayers();
    }

    @IBAction func deactivateButton(sender: AnyObject) {
        self.deactivateGameMode();
    }
    
    @IBOutlet weak var targetLabel: UILabel!
    
    var myPlayerId = PFUser.currentUser()!["player"].objectId!!
    var targetUserId:String = "";
    //var targetUser = PFUser();
    var targetPlayerId:String = "";
    
    func reactivateAll(){
        gameStateChanger(true, isMatched: false, playerId: "ng98K9gGyX")
        gameStateChanger(true, isMatched: false, playerId: "g326VU11Do")
        gameStateChanger(true, isMatched: false, playerId: "28r6nJ1769")
        gameStateChanger(true, isMatched: false, playerId: "qbWwNYCi8j")
    }
    
    func gameStateChanger(isActive: Bool,isMatched: Bool,playerId: String){
        
        let playerQuery = PFQuery(className:"Player")
        playerQuery.getObjectInBackgroundWithId(playerId) {
            (playerObj: PFObject?, error: NSError?) -> Void in
            if error == nil  {
                //print(mePlayer!)
                playerObj!["isActive"] = isActive;
                playerObj!["isMatched"] = isMatched;
                playerObj!.saveInBackground()
                print("-\(playerObj)")
            } else {
                print("\(error!) gameStateChangerError")
            }
        }
    }
    
    func deactivateGameMode(){
        gameStateChanger(false,isMatched: false,playerId: myPlayerId)
        
    }
    
    func assignTargets(){
        print("now we try to assign")
        print("myPlayerId is \(self.myPlayerId)")
        print("targetPlayer is \(self.targetPlayerId)")
        gameStateChanger(true, isMatched: true, playerId: self.myPlayerId)
        gameStateChanger(true, isMatched: true, playerId: self.targetPlayerId)
        print("Both Players are deactiveted")
        
        
    }

    func activateGameMode(){
        gameStateChanger(true,isMatched: false,playerId: myPlayerId)
        searchPlayers();
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
    }
    
    func searchPlayers(){
        // Find active, unmatched player nearby
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
                    self.targetLabel.text = "No target found"
                    if error == nil {
                        
                        let target = objects![0]
                        print( (target["username"]) , "is your target")
                        let targetMsg = String(target["username"]) + " is your target!"
                        let targetPlayer = target["player"]
                        self.targetUserId = target.objectId!
                        print("targetUserId is \(self.targetUserId)")
                        self.targetPlayerId = targetPlayer.objectId!!
                        self.targetLabel.text = targetMsg
                        self.assignTargets();
                    } else {
                        // Error finding target in query
                        print("Error: \(error!)")
                    }
                }
            }
            else{
                print("findObject \(error)")
            }
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