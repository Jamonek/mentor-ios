//
//  ViewController.swift
//  MentorAndMentees
//
//  Created by Rebouh Aymen on 15/01/2016.
//  Copyright © 2016 Mentor And Mentees. All rights reserved.
//

import UIKit
import TextFieldEffects
import Spring
import DigitsKit

class LoginViewController: BaseViewController {
  
  // MARK: Properties
  
  @IBOutlet weak var loginTitleLabel: UILabel! {
    didSet {
      loginTitleLabel.text = Localizable("Log in")
    }
  }
  
  @IBOutlet weak var signupButton: MentorButton! {
    didSet {
      signupButton.setTitle(Localizable("Sign up"), for: UIControlState())
      signupButton.layer.cornerRadius = 6.0
    }
  }
  
  @IBOutlet weak var loginButton: MentorButton! {
    didSet {
      loginButton.setTitle(Localizable("Log in with my phone number"), for: UIControlState())
      loginButton.layer.cornerRadius = 6.0
    }
  }
  
  @IBOutlet weak var loginWithPhoneNumberButton: UIButton! {
    didSet {
      // to underline the button
      let attributes                                 = [NSUnderlineStyleAttributeName: NSUnderlineStyle.styleSingle.rawValue]
      let attributedText                             = NSAttributedString(string: Localizable("Log in with my phone number"), attributes: attributes)
      loginWithPhoneNumberButton.setAttributedTitle(attributedText, for: UIControlState())
    }
  }
  
  // MARK: - Lifecycle -
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    self.title = Localizable("Log in")
  }
  
  // MARK: - User interaction -

  @IBAction func loginWithDigits(_ sender: AnyObject) {
    DigitsManager.loginWithTitle(Localizable("Mehe - Login")) { (session, error) in
      guard error == nil else { return }
      
      // If we are here, that means we have verified the user number
        
      // TODO: - Check if the phone number is registered into the database
      let isPhoneNumberRegistered = false
      
      if isPhoneNumberRegistered {
        // TODO: - Fetch the user email from the dabatase and persist it
        AWLoader.show(blurStyle: .dark)
        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + Double(Int64(2 * NSEC_PER_SEC)) / Double(NSEC_PER_SEC)) {
          AWLoader.hide()
          self.performSegue(withIdentifier: "showGroupsViewController", sender: self)
        }
      } else {
        self.performSegue(withIdentifier: "showSignupView", sender: self)
      }

    }
  }
}
