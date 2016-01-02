//
//  LeadeboardPFTableViewCell.swift
//  Appsassin0.1
//
//  Created by Catherine Hedler on 20/12/15.
//  Copyright © 2015 Parse. All rights reserved.
//

import UIKit
import Parse
import ParseUI

class LeaderboardPFTableViewCell: PFTableViewCell {

    @IBOutlet weak var avatar: PFImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var rankLabel: UILabel!
    @IBOutlet weak var killsLabel: UILabel!
    @IBOutlet weak var deathLabel: UILabel!
    @IBOutlet weak var scoreLabel: UILabel!
    @IBOutlet weak var placeLabel: UILabel!
}
