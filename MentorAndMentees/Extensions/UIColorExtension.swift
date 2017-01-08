//
//  File.swift
//  MentorAndMentees
//
//  Created by Rebouh Aymen on 15/01/2016.
//  Copyright © 2016 Mentor And Mentees. All rights reserved.
//

import UIKit

extension UIColor {
  
  struct MentorColors {
    static let skyBlueColor = UIColor(red: 108/255, green: 197/255, blue: 231/255, alpha: 1.0)
    static let mentorGreyBackgroundColor: UIColor = UIColor(red: 246/255, green: 246/255, blue: 247/255, alpha: 1.0)
  }
  
  // Used for the button colors 
  static func mentorSkyBlueColor() -> UIColor {
    return MentorColors.skyBlueColor
  }
  
  /**
    Used for the background color.
   */
  static func mentorGreyBackgroundColor() -> UIColor {
    return MentorColors.mentorGreyBackgroundColor
  }
}
