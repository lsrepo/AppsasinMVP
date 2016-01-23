//
//  Player.swift
//  Appsassin0.1
//
//  Created by Catherine Hedler on 23/01/16.
//  Copyright © 2016 Parse. All rights reserved.
//

import Foundation
import Parse


class Players {
    //this singleton contains the user's and the target player's information
    static let sharedInstance = Players()
    
    //declare variables here
    var playerStatus:String = "";
    var myPlayerId:String = "";
    var targetUserId:String = "";
    var targetPlayerId:String = "";
    var targetUsername:String = "";
    var myUsername:String = "";
    var cameraImageFromMe:UIImage = UIImage()
    var currentGameSession = PFObject(className:"Game")
    var myPlayer = PFObject(className:"Player")
    var targetPlayer = PFObject(className:"Player")
    
    func pushAssignments(targetedPlayerId:String,targetedName:String,type:String){
        // Find players in Player
        let playerQuery = PFQuery(className:"Player")
        playerQuery.whereKey("objectId", equalTo: targetedPlayerId )
        
        // Find devices associated with these users
        let pushQuery = PFInstallation.query()
        pushQuery!.whereKey("player", matchesQuery: playerQuery)
        
        // Send push notification to query
        //print("using PFpush in pushAssignment")
        let push = PFPush()
        
        var playerId:String = ""
        if (targetedPlayerId == nsa.myPlayerId){
            playerId = nsa.targetPlayerId
        }
        else{
            playerId = nsa.myPlayerId
        }
        var data:Dictionary = ["empty": ""];
        if ( type == "A"){
            data = [
                "alert" : "You're now assigned to terminate agent \(targetedName)    /M",
                "badge" : "Increment",
                "sound" : "radar.wav",
                "type" : "A",
                "playerId" : playerId,
                "gameSessionId" : nsa.currentGameSession.objectId!
            ]
        }
        else if (type == "B"){
            data = [
                "alert" : "You're terminated!",
                "badge" : "Increment",
                "type" : "B"
            ]
        }
        
        push.setData(data as [NSObject : AnyObject])
        push.setQuery(pushQuery)
        // Set our Installation query
        
        push.sendPushInBackground()
        
    }
    
    
    //declare functions here
    func gameStateChanger(isActive: Bool,isMatched: Bool,playerId: String){
        
        let playerQuery = PFQuery(className:"Player")
        playerQuery.getObjectInBackgroundWithId(playerId) {
            (playerObj: PFObject?, error: NSError?) -> Void in
            if error == nil  {
                playerObj!["isActive"] = isActive;
                playerObj!["isMatched"] = isMatched;
                playerObj!.saveInBackground()
            } else {
                print("\(error!) gameStateChangerError")
            }
        }
    }
    
    
    
    
}

let nsa = Players()