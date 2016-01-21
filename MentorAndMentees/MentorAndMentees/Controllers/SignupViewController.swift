//
//  SignupViewController.swift
//  MentorAndMentees
//
//  Created by Rebouh Aymen on 17/01/2016.
//  Copyright © 2016 Mentor And Mentees. All rights reserved.
//

import UIKit

class SignupViewController: BaseViewController {
  
  // MARK: - Properties -
  
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
  
  @IBOutlet weak var signupButton: UIButton! {
    didSet {
      signupButton.layer.cornerRadius = 3.0
      signupButton.setTitle(Localizable("Sign up"), forState: .Normal)
    }
  }

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
      profilePictureImage.layer.cornerRadius  = 55.0
      profilePictureImage.layer.masksToBounds = true
    }
  }
  
  @IBOutlet weak var fullNameTextField: HoshiTextField! {
    didSet {
      fullNameTextField.placeholder = Localizable("Full name").uppercaseString
    }
  }
  
  @IBOutlet weak var emailTextField: HoshiTextField! {
    didSet {
      emailTextField.placeholder = Localizable("Email").uppercaseString
    }
  }
  
  @IBOutlet weak var passwordTextField: HoshiTextField! {
    didSet {
      passwordTextField.placeholder = Localizable("Password").uppercaseString
    }
  }
  
  @IBOutlet weak var birthdayTextField: HoshiTextField! {
    didSet {
      birthdayTextField.placeholder = Localizable("Birthday").uppercaseString
    }
  }
  
  @IBOutlet weak var mentorSegmentedControl: AWSegmentedControlView! {
    didSet {
      mentorSegmentedControl.dataSource = self
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
    }
  }
  
  func imagePickerControllerDidCancel(picker: UIImagePickerController) {
    picker.dismissViewControllerAnimated(true, completion: nil)
  }
}

// MARK: - AWSegmentedControlView Data source -

extension SignupViewController: AWSegmentedControlViewDataSource {
  func titlesForAWSegmentedControlView(awSegmentedControlView: AWSegmentedControlView) -> AWSegmentedControlViewTitles {
    return (left: Localizable("Mentor"), right: Localizable("Mentee"))
  }
  
  func imagesNamesForAWSegmentedControlView(awSegmentedControlView: AWSegmentedControlView) -> AWSegmentedControlViewImages {
    return (left: "mentor", right: "mentee")
  }
}


