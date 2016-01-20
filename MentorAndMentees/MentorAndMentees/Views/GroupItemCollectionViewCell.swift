//
//  GroupItemCollectionViewCell.swift
//  MentorAndMentees
//
//  Created by Rebouh Aymen on 20/01/2016.
//  Copyright © 2016 Mentor And Mentees. All rights reserved.
//

import UIKit

class GroupItemCollectionViewCell: UICollectionViewCell {
  
  // MARK: - Properties -

  @IBOutlet weak var iconImageView: UIImageView!
  @IBOutlet weak var nameLabel: UILabel!
  @IBOutlet weak var membersLabel: UILabel!
  @IBOutlet weak var lastActivityLabel: UILabel!
  
  // MARK: - Lifecycle -
  
  required init?(coder aDecoder: NSCoder) {
    super.init(coder: aDecoder)
    
    layer.cornerRadius = 4.0
  }

}
