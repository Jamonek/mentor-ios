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

class LoginViewController: BaseViewController {
  
  // MARK: - Properties -
  
  @IBOutlet weak var emailTextField: HoshiTextField!
  @IBOutlet weak var passwordTextField: HoshiTextField!
  
  @IBOutlet weak var loginButton: UIButton! {
    didSet {
      loginButton.layer.cornerRadius = 3.0
    }
  }
  
  @IBOutlet weak var signupButton: UIButton! {
    didSet {
      signupButton.layer.cornerRadius = 3.0
    }
  }
  
  @IBOutlet weak var resetPasswordButton: UIButton! {
    didSet {
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
    
    NSNotificationCenter.defaultCenter().addObserver(self, selector: "keyboardWillShowOrHide:", name: UIKeyboardWillShowNotification, object: nil)
    NSNotificationCenter.defaultCenter().addObserver(self, selector: "keyboardWillShowOrHide:", name: UIKeyboardWillHideNotification, object: nil)
  }
  
  // MARK: - User interaction -
  
  @IBAction func login(sender: AnyObject) {

  }
  
  @IBAction func showOrHidePassword(sender: AnyObject) {
    passwordTextField.secureTextEntry = !passwordTextField.secureTextEntry
    showPasswordButton.selected       = !showPasswordButton.selected
  }
}

// MARK: - UITextField Delegate -

extension LoginViewController: UITextFieldDelegate {
  func textFieldShouldReturn(textField: UITextField) -> Bool {
    textField.resignFirstResponder()
    return true
  }
}

// MARK: - UIKeyboard Notification -

extension LoginViewController {
  
  private struct ButtonProperties {
    static let margin: CGFloat = 10.0
  }
  
  func keyboardWillShowOrHide(notification: NSNotification) {
    let keyboardBeginFrame = (notification.userInfo![UIKeyboardFrameBeginUserInfoKey] as! NSValue).CGRectValue()
    let keyboardEndFrame = (notification.userInfo![UIKeyboardFrameEndUserInfoKey] as! NSValue).CGRectValue()
    
    // IF the keyboard is moving
    if keyboardBeginFrame != keyboardEndFrame {
      
      /*
        If the login button is not on top of keyboard ( loginButton.frame.minY > keyboardEndFrame.minY  ), we put it above
        Else, we put it on the bottom of the view ( `margin` from the bottom )
      */
      let constantBottom: CGFloat = loginButton.frame.minY > keyboardEndFrame.minY ? keyboardEndFrame.height + ButtonProperties.margin : ButtonProperties.margin

      UIView.animateWithDuration(0.5, animations: {
        self.loginButtonBottomConstraint.constant         = constantBottom;
        self.resetPasswordButtonBottomConstraint.constant = constantBottom;
        self.view.layoutIfNeeded()
        }, completion: nil)
    }
  }
}
