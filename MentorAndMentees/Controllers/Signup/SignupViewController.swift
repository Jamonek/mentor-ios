//
//  SignupViewController.swift
//  MentorAndMentees
//
//  Created by Rebouh Aymen on 17/01/2016.
//  Copyright © 2016 Mentor And Mentees. All rights reserved.
//

import UIKit
import Spring

class SignupViewController:  BaseKeyboardNotificationViewController {
  
  // MARK: - Properties -
  
  var profilePicture: UIImage?
  
  @IBOutlet weak var signupTitleLabel: UILabel! {
    didSet {
      signupTitleLabel.text = Localizable("Sign up")
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
  
  @IBOutlet weak var nextButtonBottomConstraint: NSLayoutConstraint!
  
  lazy var imagePickerController: UIImagePickerController = {
    let imagePickerController = UIImagePickerController()
    imagePickerController.delegate = self
    imagePickerController.allowsEditing = true
    return imagePickerController
  }()
  
  @IBOutlet weak var addProfilePictureButton: UIButton! {
    didSet {
      addProfilePictureButton.layer.cornerRadius  = 15.0
    }
  }
  
  @IBOutlet weak var profilePictureImage: UIImageView! {
    didSet {
      profilePictureImage.layer.cornerRadius  = profilePictureImage.bounds.height / 2
      profilePictureImage.layer.masksToBounds = true
    }
  }
  
  @IBOutlet weak var fullNameSpringTextField: SpringTextField! {
    didSet {
      fullNameSpringTextField.placeholder = Localizable("Full name")
    }
  }
  
  // MARK: - Lifecycle -
  
  override func viewWillAppear(animated: Bool) {
    super.viewWillAppear(animated)
    fullNameSpringTextField.becomeFirstResponder()
  }
  
  override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
    if let signupEmailController = segue.destinationViewController as? SignupEmailViewController {
      signupEmailController.fullName = fullNameSpringTextField.text!
      signupEmailController.profilePicture = profilePicture
    }
  }
  
  // MARK: - User Interaction -
  
  @IBAction func showImagePicker(sender: AnyObject) {
    presentViewController(imagePickerController, animated: true, completion: nil)
  }
}

// MARK: - UIImagePickerController Delegate -

extension SignupViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
  func imagePickerController(picker: UIImagePickerController, didFinishPickingImage image: UIImage, editingInfo: [String : AnyObject]?) {
    picker.dismissViewControllerAnimated(true) {
      self.profilePictureImage.image = image
      self.profilePicture = image
    }
  }
  
  func imagePickerControllerDidCancel(picker: UIImagePickerController) {
    picker.dismissViewControllerAnimated(true, completion: nil)
  }
}

// MARK: - UITextField Delegate -

extension SignupViewController: UITextFieldDelegate {
  func textField(textField: UITextField, shouldChangeCharactersInRange range: NSRange, replacementString string: String) -> Bool {
    
    let completeName = (textField.text! as NSString).stringByReplacingCharactersInRange(range, withString: string)
    nextButton.enabled = completeName.length < 2 ? false : true
    
    return true
  }
  
  func textFieldShouldClear(textField: UITextField) -> Bool {
    nextButton.enabled = false
    return true
  }
}


// MARK: - UIKeyboard Notification -

extension SignupViewController {
  func keyboardWillShow(notification: NSNotification) {
    let keyboardEndFrame                     = (notification.userInfo![UIKeyboardFrameEndUserInfoKey] as! NSValue).CGRectValue()
    let constantBottom: CGFloat              = keyboardEndFrame.height + ButtonProperties.margin
    self.nextButtonBottomConstraint.constant = constantBottom
  }
}


