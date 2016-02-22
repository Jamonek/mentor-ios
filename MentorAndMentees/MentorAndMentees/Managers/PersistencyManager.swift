//
//  PersistencyManager.swift
//  MentorAndMentees
//
//  Created by Rebouh Aymen on 21/02/2016.
//  Copyright © 2016 Mentor And Mentees. All rights reserved.
//

import Foundation

struct PersistencyManager {
  
  // MARK: - User Session -
  
  static func saveSession(email email: String) {
    NSUserDefaults.standardUserDefaults().setObject(email, forKey: "email")
  }
  
  static func clearSession() {
    NSUserDefaults.standardUserDefaults().removeObjectForKey("email")
  }
}