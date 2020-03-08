//
//  ReferenceOnFirebase.swift
//  notes
//
//  Created by Pavel Anpleenko on 24/11/2019.
//  Copyright © 2019 Pavel Anpleenko. All rights reserved.
//

import Firebase

class Reference {
  static let reference = Reference()
  
  public func correctReference() -> DatabaseReference {
    return Database.database().reference()
  }
  
  public func returnUserID() -> String {
    if let userID = Auth.auth().currentUser?.uid {
      return userID
    } else {
      return ""
    }
  }
  
}

