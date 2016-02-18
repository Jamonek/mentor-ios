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

class LoginViewController: BaseKeyboardNotificationViewController {
  
  // MARK: - Properties -
  
  @IBOutlet weak var loginTitleLabel: UILabel! {
    didSet {
      loginTitleLabel.text = Localizable("Log in")
    }
  }
  
  @IBOutlet weak var emailTextField: HoshiTextField! {
    didSet {
      emailTextField.placeholder = Localizable("Email").uppercaseString
    }
  }
  
  @IBOutlet weak var passwordTextField: HoshiTextField!  {
    didSet {
      passwordTextField.placeholder = Localizable("Password").uppercaseString
    }
  }
  
  @IBOutlet weak var loginButton: UIButton! {
    didSet {
      loginButton.layer.cornerRadius = 3.0
      loginButton.setTitle(Localizable("Log in"), forState: .Normal)
    }
  }
  
  @IBOutlet weak var signupButton: UIButton! {
    didSet {
      signupButton.layer.cornerRadius = 3.0
      signupButton.setTitle(Localizable("Sign up"), forState: .Normal)
    }
  }
  
  @IBOutlet weak var resetPasswordButton: UIButton! {
    didSet {
      resetPasswordButton.setTitle(Localizable("Reset your password"), forState: .Normal)
      
      // to underline the reset button
      let attributes                                 = [NSUnderlineStyleAttributeName: NSUnderlineStyle.StyleSingle.rawValue]
      let attributedText                             = NSAttributedString(string: resetPasswordButton.currentTitle!, attributes: attributes)
      resetPasswordButton.titleLabel!.attributedText = attributedText
    }
  }
  
  @IBOutlet weak var showPasswordButton: UIButton!
  @IBOutlet weak var loginButtonBottomConstraint: NSLayoutConstraint!
  @IBOutlet weak var resetPasswordButtonBottomConstraint: NSLayoutConstraint!
  
  // MARK: - Lifecycle -
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    self.title = Localizable("Log in")
  }
  
  override func viewWillAppear(animated: Bool) {
    super.viewWillAppear(animated)
    
    emailTextField.becomeFirstResponder()
  }
  
  // MARK: - User interaction -
  
  @IBAction func login(sender: AnyObject) {
    
  }
  
  @IBAction func showOrHidePassword(sender: AnyObject) {
    passwordTextField.secureTextEntry = !passwordTextField.secureTextEntry
    showPasswordButton.selected       = !showPasswordButton.selected
  }
}

// MARK: - UIKeyboard Notification -

extension LoginViewController {
  func keyboardWillShow(notification: NSNotification) {
    let keyboardEndFrame                              = (notification.userInfo![UIKeyboardFrameEndUserInfoKey] as! NSValue).CGRectValue()
    let constantBottom: CGFloat                       = keyboardEndFrame.height + ButtonProperties.margin
    self.loginButtonBottomConstraint.constant         = constantBottom
    self.resetPasswordButtonBottomConstraint.constant = constantBottom
  }
}
