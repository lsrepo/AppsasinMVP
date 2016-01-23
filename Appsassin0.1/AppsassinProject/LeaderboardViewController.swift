//
//  LeaderboardViewController.swift
//  Appsassin0.1
//
//  Created by Catherine Hedler on 20/12/15.
//  Copyright © 2015 Parse. All rights reserved.
//

import UIKit
import Parse
import ParseUI

class LeaderboardViewController: PFQueryTableViewController {
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        
        // The className to query on
        self.parseClassName = "Player"
        self.pullToRefreshEnabled = true
        self.paginationEnabled = false
        self.objectsPerPage = 25
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    override func queryForTable() -> PFQuery {
        let query = super.queryForTable()
        
        query.orderByDescending("score")
        
        return query
    }
    
  
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath, object: PFObject?) -> PFTableViewCell? {
        let cellIdentifier = "leaderboardPFCell"
            
        var cell = tableView.dequeueReusableCellWithIdentifier(cellIdentifier) as? LeaderboardPFTableViewCell
        if cell == nil {
            cell = LeaderboardPFTableViewCell (style: .Default, reuseIdentifier: cellIdentifier)
        }
        
        if let thumbnail = object?["image"] as? PFFile {
            cell?.avatar.file = thumbnail
            cell?.avatar.loadInBackground()
        }
        
        cell!.nameLabel!.text = "\(object!["username"])"
        cell!.killsLabel.text = "\(object!["kills"])"
        cell!.deathLabel.text = "\(object!["deaths"])"
        cell!.scoreLabel.text = "\(object!["score"])"
        cell!.placeLabel.text = "\(indexPath.row + 1)"
        
        return cell
    }
    
}