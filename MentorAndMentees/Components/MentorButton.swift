//
//  MentorButton.swift
//  MentorAndMentees
//
//  Created by Rebouh Aymen on 05/02/2016.
//  Copyright © 2016 Mentor And Mentees. All rights reserved.
//

import UIKit

class MentorButton: UIButton {

  override var isEnabled: Bool {
    didSet {
      if isEnabled {
        backgroundColor = UIColor.mentorSkyBlueColor()
      } else {
        backgroundColor = UIColor.lightGray
      }
    }
  }
  
  required init?(coder aDecoder: NSCoder) {
    super.init(coder: aDecoder)
    
    layer.cornerRadius = 3.0
  }

}
