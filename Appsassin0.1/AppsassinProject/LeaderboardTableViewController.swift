//
//  LeaderboardTableViewController.swift
//  Appsassin0.1
//
//  Created by Catherine Hedler on 18/12/15.
//  Copyright © 2015 Parse. All rights reserved.
//

import UIKit
import Parse

class LeaderboardTableViewController: UITableViewController {
    
    var playerData = [PFObject]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillAppear(animated: Bool) {
        
        let query = PFQuery(className:"Player")
        //query.whereKey("playerName", equalTo:"Sean Plott")
        query.findObjectsInBackgroundWithBlock {
            (objects: [PFObject]?, error: NSError?) -> Void in
            
            if error == nil {
                self.playerData = objects!
                print(self.playerData)
                
                // The find succeeded.
//                print("Successfully retrieved \(objects!.count) scores.")
                // Do something with the found objects
//                if let objects = objects {
//                    for object in objects {
//                        print(object["score"])
//
//                    }
//                }
            } else {
                // Log details of the failure
                print("Error: \(error!) \(error!.userInfo)")
            }
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 10
    }

    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("leaderboardCell", forIndexPath: indexPath) //as! LeaderboardTableViewCell
        
        //FOR PROTOTYPING:
        
        
        
        
        //FOR IMPLEMENTATION:
        
        //let entry = playerData.users[indexPath.row]
        
        //change name and name label to what it is...
        
        //cell.placeLabel.text = entry.place (displays "1" or "2" etc depending on the place. this can be stored in the leaderboard data array or maybe calculated locally?)
        //cell.nameLabel.text = entry.name
        //cell.killsLabel.text = entry.kills
        //cell.deathsLabel.text = entry.deaths
        //cell.scoreLabel.text = entry.score
        
        //Photo???

        return cell
    }


    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
