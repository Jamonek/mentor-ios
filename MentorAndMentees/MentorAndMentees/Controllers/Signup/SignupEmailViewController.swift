//
//  SignupViewController.swift
//  MentorAndMentees
//
//  Created by Rebouh Aymen on 17/01/2016.
//  Copyright © 2016 Mentor And Mentees. All rights reserved.
//

import UIKit
import Spring

class SignupEmailViewController: BaseKeyboardNotificationViewController {
  
  // MARK: - Properties -
  
  @IBOutlet weak var emailTitleLabel: UILabel! {
    didSet {
      emailTitleLabel.text = Localizable("Your email, please")
    }
  }
  
  @IBOutlet weak var backButton: UIButton!  {
    didSet {
      backButton.layer.cornerRadius = 3.0
    }
  }
  
  @IBOutlet weak var nextButton: MentorButton! {
    didSet {
      nextButton.setTitle(Localizable("Next"), forState: .Normal)
    }
  }
  
  @IBOutlet weak var emailSpringTextField: SpringTextField! {
    didSet {
      emailSpringTextField.placeholder = Localizable("Email")
    }
  }
  
  @IBOutlet weak var emailUseDescriptionLabel: UILabel! {
    didSet {
      emailUseDescriptionLabel.text = Localizable("Use of email")
    }
  }
  
  @IBOutlet weak var backButtonBottomConstraint: NSLayoutConstraint!
  @IBOutlet weak var nextButtonBottomConstraint: NSLayoutConstraint!
  
  // MARK: - Lifecycle -
  
  override func viewWillAppear(animated: Bool) {
    super.viewWillAppear(animated)
    
    emailSpringTextField.becomeFirstResponder()
  }
  
  // MARK: - Fields Validation -
  
  private struct Regex {
    static let email = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,}"
  }
  
  func isEmailValid(email: String) -> Bool {
    let regex = Regex.email
    return NSPredicate(format: "SELF MATCHES %@", regex).evaluateWithObject(email)
  }
}


// MARK: - UITextField Delegate -

extension SignupEmailViewController: UITextFieldDelegate {
  func textField(textField: UITextField, shouldChangeCharactersInRange range: NSRange, replacementString string: String) -> Bool {
    
    let email = (textField.text! as NSString).stringByReplacingCharactersInRange(range, withString: string)
    nextButton.enabled = isEmailValid(email)
    
    return true
  }
  
  func textFieldShouldClear(textField: UITextField) -> Bool {
    nextButton.enabled = false
    return true
  }
}


// MARK: - UIKeyboard Notification -

extension SignupEmailViewController {
  
  func keyboardWillShow(notification: NSNotification) {
    let keyboardEndFrame                     = (notification.userInfo![UIKeyboardFrameEndUserInfoKey] as! NSValue).CGRectValue()
    let constantBottom: CGFloat              = keyboardEndFrame.height + ButtonProperties.margin
    self.nextButtonBottomConstraint.constant = constantBottom
    self.backButtonBottomConstraint.constant = constantBottom
  }
}

