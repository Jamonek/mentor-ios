//
//  MentorButton.swift
//  MentorAndMentees
//
//  Created by Rebouh Aymen on 05/02/2016.
//  Copyright © 2016 Mentor And Mentees. All rights reserved.
//

import UIKit

class MentorButton: UIButton {

  override var enabled: Bool {
    didSet {
      if enabled {
        backgroundColor = UIColor.mentorSkyBlueColor()
      } else {
        backgroundColor = UIColor.lightGrayColor()
      }
    }
  }
  
  required init?(coder aDecoder: NSCoder) {
    super.init(coder: aDecoder)
    
    layer.cornerRadius = 3.0
  }

}
