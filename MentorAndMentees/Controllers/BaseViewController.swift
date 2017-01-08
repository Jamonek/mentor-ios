//
//  BaseViewController.swift
//  MentorAndMentees
//
//  Created by Rebouh Aymen on 15/01/2016.
//  Copyright © 2016 Mentor And Mentees. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa

/**
 Used to have common properties for all views controllers like the background color.
 */
class BaseViewController: UIViewController {
  
  // MARK: - Properties -
  
  lazy var disposeBag = DisposeBag()

  // MARK: - Lifecycle -

  override func viewDidLoad() {
    super.viewDidLoad()
    
    self.view.backgroundColor = UIColor.mentorGreyBackgroundColor()
  }
}

