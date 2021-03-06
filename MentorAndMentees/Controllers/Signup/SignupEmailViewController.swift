//
//  SignupViewController.swift
//  MentorAndMentees
//
//  Created by Rebouh Aymen on 17/01/2016.
//  Copyright © 2016 Mentor And Mentees. All rights reserved.
//

import UIKit
import Spring
import Fabric
import DigitsKit
import TwitterKit

class SignupEmailViewController: BaseKeyboardNotificationViewController {
  
  // MARK: - Properties -
  
  var profilePicture: UIImage?
  var fullName: String!
  
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
      nextButton.setTitle(Localizable("Next"), for: UIControlState())
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
  
  override func viewWillAppear(_ animated: Bool) {
    super.viewWillAppear(animated)
    
    emailSpringTextField.becomeFirstResponder()
  }
  
  // MARK: - Fields Validation -
  
  fileprivate struct Regex {
    static let email = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,}"
  }
  
  func isEmailValid(_ email: String) -> Bool {
    let regex = Regex.email
    return NSPredicate(format: "SELF MATCHES %@", regex).evaluate(with: email)
  }
  
  // MARK: - User Interaction -
  
  @IBAction func showNumberVerificationWithDigits(_ sender: AnyObject) {
    if Digits.sharedInstance().session() == nil {
      DigitsManager.loginWithTitle(Localizable("Mehe - User Verification")) { (session, error) in
        guard error == nil else { return }
        
        // TODO: - Signup request
        // TODO: - Persistency of the email
        print("User from signup")
        print("Digits user ID: \(Digits.sharedInstance().session()?.userID)")
        print("Digits phone number: \(Digits.sharedInstance().session()?.phoneNumber)")
        print("Digits email address: \(Digits.sharedInstance().session()?.emailAddress)")
        print("Digits token: \(Digits.sharedInstance().session()?.authToken)")
        print("Digits token secret: \(Digits.sharedInstance().session()?.authTokenSecret)")
        print("Mehe email: \(self.emailSpringTextField.text)")
        print("Mehe name: \(self.fullName)")
        let digit = Digits.sharedInstance()
        let oauthSigning = DGTOAuthSigning(authConfig:digit.authConfig, authSession:digit.session())
        let authHeaders = oauthSigning.oAuthEchoHeadersToVerifyCredentials()
        print("X-Auth-Service-Provider: \(authHeaders["X-Auth-Service-Provider"])")
        print("X-Verify-Credentials-Authorization: \(authHeaders["X-Verify-Credentials-Authorization"])")
        print("Auth header: \(authHeaders)")
        self.performSegue(withIdentifier: "goToGroupsList", sender: self)
      }
      
    // We logged in the user with a phone number but the user is not registered
    } else {
      print("User from login")
      // TODO: - Signup request with phoneNumber ( Digits session ), email, fullName, profilePicture
      // TODO: - Persistency of the email
        print("Digits user ID: \(Digits.sharedInstance().session()?.userID)")
        print("Digits phone number: \(Digits.sharedInstance().session()?.phoneNumber)")
        print("Digits email address: \(Digits.sharedInstance().session()?.emailAddress)")
        print("Digits token: \(Digits.sharedInstance().session()?.authToken)")
        print("Digits token secret: \(Digits.sharedInstance().session()?.authTokenSecret)")
        print("Mehe email: \(emailSpringTextField.text)")
        print("Mehe name: \(fullName)")
        let digit = Digits.sharedInstance()
        let oauthSigning = DGTOAuthSigning(authConfig:digit.authConfig, authSession:digit.session())
        let authHeaders = oauthSigning?.oAuthEchoHeadersToVerifyCredentials()
        print("X-Auth-Service-Provider: \(authHeaders?["X-Auth-Service-Provider"])")
        print("X-Verify-Credentials-Authorization: \(authHeaders?["X-Verify-Credentials-Authorization"])")
        UserManager.credCheck(authHeaders)
        print("Auth header: \(authHeaders)")
      emailSpringTextField.resignFirstResponder()
      AWLoader.show(blurStyle: .dark)
      DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + Double(Int64(2 * NSEC_PER_SEC)) / Double(NSEC_PER_SEC)) {
        AWLoader.hide()
        self.performSegue(withIdentifier: "goToGroupsList", sender: self)
      }

    }
  }
}


// MARK: - UITextField Delegate -

extension SignupEmailViewController: UITextFieldDelegate {
  func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
    
    let email = (textField.text! as NSString).replacingCharacters(in: range, with: string)
    nextButton.isEnabled = isEmailValid(email)
    
    return true
  }
  
  func textFieldShouldClear(_ textField: UITextField) -> Bool {
    nextButton.isEnabled = false
    return true
  }
}


// MARK: - UIKeyboard Notification -

extension SignupEmailViewController {
  
  func keyboardWillShow(_ notification: Notification) {
    let keyboardEndFrame                     = (notification.userInfo![UIKeyboardFrameEndUserInfoKey] as! NSValue).cgRectValue
    let constantBottom: CGFloat              = keyboardEndFrame.height + ButtonProperties.margin
    self.nextButtonBottomConstraint.constant = constantBottom
    self.backButtonBottomConstraint.constant = constantBottom
  }
}
