//
//  SpringTextFieldExtension.swift
//  MentorAndMentees
//
//  Created by Rebouh Aymen on 16/01/2016.
//  Copyright © 2016 Mentor And Mentees. All rights reserved.
//

import Spring

extension SpringTextField {
  func shake() {
    self.animation = "shake"
    self.duration = 1.0
    self.animate()
  }
}

