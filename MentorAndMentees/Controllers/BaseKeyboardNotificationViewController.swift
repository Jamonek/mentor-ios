//
//  BaseKeyboardNotificationViewController.swift
//  MentorAndMentees
//
//  Created by Rebouh Aymen on 05/02/2016.
//  Copyright © 2016 Mentor And Mentees. All rights reserved.
//

import UIKit

class BaseKeyboardNotificationViewController: BaseViewController {

  // MARK: - Properties -
  
  // The margin between the keyboard and buttons above
  struct ButtonProperties {
    static let margin: CGFloat = 10.0
  }
  
  // MARK: - Lifecycle -

  override func viewDidLoad() {
    super.viewDidLoad()
    
    // FIXME: Fix for #selector()
    //NSNotificationCenter.defaultCenter().addObserver(self, selector: "keyboardWillShow:", name: UIKeyboardWillShowNotification, object: nil)
  }
}
