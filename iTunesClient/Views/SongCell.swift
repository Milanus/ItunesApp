//
//  SongCell.swift
//  iTunesClient
//
//  Created by Milan Schon on 06/01/2019.
//  Copyright © 2019 Milan Schon. All rights reserved.
//

import UIKit

class SongCell: UITableViewCell {

    static let reusedIdentifier = "SongCell"
    
    @IBOutlet weak var songTitleLabel: UILabel!
    @IBOutlet weak var songRuntimeLabel: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
