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
  
  @IBOutlet weak var backButton: UIButton!  {
    didSet {
      backButton.layer.cornerRadius = 3.0
    }
  }
  
  @IBOutlet weak var signupButton: UIButton! {
    didSet {
      signupButton.layer.cornerRadius = 3.0
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
  
  @IBOutlet weak var fullNameTextField: HoshiTextField!
  @IBOutlet weak var emailTextField: HoshiTextField!
  @IBOutlet weak var passwordTextField: HoshiTextField!
  @IBOutlet weak var birthdayTextField: HoshiTextField!
  
  // MARK: - Lifecycle -

  override func viewDidLoad() {
    super.viewDidLoad()
    
    self.title = Localizable("Sign up")
    self.navigationController?.navigationBarHidden = true
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




