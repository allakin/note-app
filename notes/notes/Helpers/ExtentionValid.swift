//
//  ExtentionValidEmail.swift
//  notes
//
//  Created by Pavel Anpleenko on 05/10/2019.
//  Copyright © 2019 Pavel Anpleenko. All rights reserved.
//

import Foundation

extension String {
  
  enum ValidityType {
    case email
    case password
  }
  
  enum Regex: String {
    case email = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
    case password = "^(?=.*[A-Za-z])(?=.*\\d)[A-Za-z\\d]{10,}$" //Minimum 10 characters at least 1 Alphabet and 1 Number
  }
  
  func isValid(_ validdityType: ValidityType) -> Bool {
    let format = "SELF MATCHES %@"
    var regex = ""
    
    switch validdityType {
    case .email:
      regex = Regex.email.rawValue
    case .password:
      regex = Regex.password.rawValue
    default:
      regex = ""
    }
    return NSPredicate(format: format, regex).evaluate(with: self)
  }
  
}
