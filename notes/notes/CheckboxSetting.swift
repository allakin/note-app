//
//  CheckboxStates.swift
//  notes
//
//  Created by Pavel Anpleenko on 12.01.2020.
//  Copyright © 2020 Pavel Anpleenko. All rights reserved.
//

import UIKit
import Foundation

extension LoginViewController {
  func checkboxON() {
    checkBoxButton.layer.cornerRadius = 4
    checkBoxButton.layer.borderWidth = 1
//    checkBoxButton.layer.borderColor = UIColor.LightOrangeColor.cgColor
    checkBoxButton.backgroundColor = UIColor.LightOrangeColor
    userDefault.set(emailTextField.text, forKey: "userLogin")
    userDefault.set(passwordTextField.text, forKey: "userPassword")
    userDefault.set(true, forKey: "stateCheckbox")
  }
  
  func checkboxOFF() {
    checkBoxButton.layer.cornerRadius = 4
    checkBoxButton.backgroundColor = .clear
    checkBoxButton.layer.borderWidth = 1
    checkBoxButton.layer.borderColor = UIColor.LightGrayColor.cgColor
    userDefault.removeObject(forKey: "userLogin")
    userDefault.removeObject(forKey: "userPassword")
    userDefault.removeObject(forKey: "stateCheckbox")
    userDefault.set(false, forKey: "stateCheckbox")
  }
}
