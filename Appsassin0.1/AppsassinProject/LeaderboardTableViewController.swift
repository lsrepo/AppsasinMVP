//////
//////  LeaderboardTableViewController.swift
//////  Appsassin0.1
//////
//////  Created by Catherine Hedler on 18/12/15.
//////  Copyright © 2015 Parse. All rights reserved.
//////
////
////import UIKit
////import Parse
////
////class LeaderboardTableViewController: UITableViewController {
////
////    var playerData = [PFObject]()
////
////    override func viewDidLoad() {
////        super.viewDidLoad()
////    }
////
////    override func viewWillAppear(animated: Bool) {
////        let query = PFQuery(className:"Player")
////        //query.whereKey("playerName", equalTo:"Sean Plott")
////        query.findObjectsInBackgroundWithBlock {
////            (objects: [PFObject]?, error: NSError?) -> Void in
////
////            if error == nil {
////                self.playerData = objects!
////                print("There is data for \(self.playerData.count) players on the leaderboard")
////                print(objects)
////
////            } else {
////                // Log details of the failure
////                print("Error: \(error!) \(error!.userInfo)")
////            }
////        }
////
////    }
////
//
//
//import UIKit
//import Parse
//
//class LeaderboardTableViewController: UITableViewController {
//
//    var playerData = [PFObject]()
//
//    override func viewDidLoad() {
//        super.viewDidLoad()
//    }
//
//    override func viewWillAppear(animated: Bool) {
//        let query = PFQuery(className:"Player")
//        //query.whereKey("playerName", equalTo:"Sean Plott")
//        query.findObjectsInBackgroundWithBlock {
//            (objects: [PFObject]?, error: NSError?) -> Void in
//
//            if error == nil {
//                self.playerData = objects!
//                print("There is data for \(self.playerData.count) players on the leaderboard")
//                print(objects)
//
//            } else {
//                // Log details of the failure
//                print("Error: \(error!) \(error!.userInfo)")
//            }
//        }
//
//    }
//
//    override func didReceiveMemoryWarning() {
//        super.didReceiveMemoryWarning()
//        // Dispose of any resources that can be recreated.
//    }
//
//    // MARK: - Table view data source
//
//    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
//        return 1
//    }
//
//    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
//        return playerData.count
//    }
//
//    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
//        let cell = tableView.dequeueReusableCellWithIdentifier("leaderboardCell", forIndexPath: indexPath) as! LeaderboardTableViewCell
//
//        let entry = playerData[indexPath.row]
//
//        //cell.placeLabel.text = entry.place (displays "1" or "2" etc depending on the place. this can be stored in the leaderboard data array or maybe calculated locally?)
//        //Photo???
//
//        cell.nameLabel!.text = "\(entry["username"])"
//        cell.killsLabel.text = "\(entry["kills"])"
//        cell.deathsLabel.text = "\(entry["deaths"])"
//        cell.scoreLabel.text = "\(entry["score"])"
//
//        return cell
//    }
//
//    /*
//    // MARK: - Navigation
//
//    // In a storyboard-based application, you will often want to do a little preparation before navigation
//    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
//        // Get the new view controller using segue.destinationViewController.
//        // Pass the selected object to the new view controller.
//    }
//    */
//
//}
//=======
////    override func didReceiveMemoryWarning() {
////        super.didReceiveMemoryWarning()
////        // Dispose of any resources that can be recreated.
////    }
////
////    // MARK: - Table view data source
////
////    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
////        return 1
////    }
////
////    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
////        return playerData.count
////    }
////
////    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
////        let cell = tableView.dequeueReusableCellWithIdentifier("leaderboardCell", forIndexPath: indexPath) as! LeaderboardTableViewCell
////
////        let entry = playerData[indexPath.row]
////
////        //cell.placeLabel.text = entry.place (displays "1" or "2" etc depending on the place. this can be stored in the leaderboard data array or maybe calculated locally?)
////        //Photo???
////
//////        cell.nameLabel!.text = entry["username"] as! String
//////        cell.killsLabel.text = "\(entry["kills"])"
//////        cell.deathsLabel.text = "\(entry["deaths"])"
//////        cell.scoreLabel.text = "\(entry["score"])"
////
////        return cell
////    }
////
////    /*
////    // MARK: - Navigation
////
////    // In a storyboard-based application, you will often want to do a little preparation before navigation
////    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
////        // Get the new view controller using segue.destinationViewController.
////        // Pass the selected object to the new view controller.
////    }
////    */
////
////}
//>>>>>>> c36f3d33a83a4ec9fc64144e48d4d5dd70d02eba
