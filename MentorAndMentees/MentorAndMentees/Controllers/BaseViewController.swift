//
//  BaseViewController.swift
//  MentorAndMentees
//
//  Created by Rebouh Aymen on 15/01/2016.
//  Copyright © 2016 Mentor And Mentees. All rights reserved.
//

import UIKit

/**
 Used to have common properties for all views controllers like the background color.
 */
class BaseViewController: UIViewController {
  
  // MARK: - Lifecycle -

  override func viewDidLoad() {
    super.viewDidLoad()
    
    self.view.backgroundColor = UIColor.mentorGreyBackgroundColor()
  }
  
  // MARK: - Gesture events -
  
  // Called when the user touch a point anywhere on the screen
  override func touchesEnded(touches: Set<UITouch>, withEvent event: UIEvent?) {
    view.endEditing(true)
  }
}
