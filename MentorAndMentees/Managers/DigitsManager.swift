//
//  DigitsManager.swift
//  MentorAndMentees
//
//  Created by Rebouh Aymen on 21/02/2016.
//  Copyright © 2016 Mentor And Mentees. All rights reserved.
//

import Foundation
import DigitsKit

struct DigitsManager {

  static func loginWithTitle(_ title: String, phoneNumber: String = "", completionHandler: @escaping DGTAuthenticationCompletion) {
    let digits                 = Digits.sharedInstance()
    let configuration          = DGTAuthenticationConfiguration(accountFields: .none)
    let appearance             = DGTAppearance()
    appearance.accentColor     = UIColor.mentorSkyBlueColor()
    appearance.backgroundColor = UIColor.mentorGreyBackgroundColor()
    appearance.logoImage       = UIImage(named: "iconApp")
    configuration?.appearance   = appearance
    configuration?.title        = title
    
    if phoneNumber.isNotEmpty {
    configuration?.phoneNumber  = "+33623185407"
    }

    digits.authenticate(with: nil, configuration: configuration!) { (session, error)  in
      completionHandler(session, error)
    }
  }
}
