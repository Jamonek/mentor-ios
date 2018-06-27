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
  
  static func saveSession(email: String) {
    UserDefaults.standard.set(email, forKey: "email")
  }
  
  static func clearSession() {
    UserDefaults.standard.removeObject(forKey: "email")
  }
}
