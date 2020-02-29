//
//  EditUserSettingViewController.swift
//  notes
//
//  Created by Pavel Anpleenko on 23.02.2020.
//  Copyright © 2020 Pavel Anpleenko. All rights reserved.
//

import UIKit
import TextFieldEffects

class EditUserSettingViewController: UIViewController {
	
  let emailTextField = HoshiTextField()
  let passwordTextField = HoshiTextField()
  
  let editLabel: UILabel = {
    let label = UILabel()
    label.font = UIFont.boldSystemFont(ofSize: 20)
    label.textAlignment = .center
    label.translatesAutoresizingMaskIntoConstraints = false
    label.text = "Изменение профиля"
    label.textColor = .TextGrayColor
    label.lineBreakMode = .byWordWrapping
    return label
  }()
  
	override func viewDidLoad() {
		super.viewDidLoad()
		view.backgroundColor = .white
    settingEmailTextField()
    settingPasswordTextField()
    setingUI()
    
	}
  
  func settingEmailTextField() {
    emailTextField.placeholderColor = .TextGrayColor
    emailTextField.borderInactiveColor = .LightGrayColor
    emailTextField.borderActiveColor = .MainGreenColor
    emailTextField.textColor = .TextGrayColor
    emailTextField.placeholder = "Укажите ваш email"
    emailTextField.font = UIFont(name: "Helvetica", size: 16)
    emailTextField.placeholderFontScale = 1
    emailTextField.keyboardType = .emailAddress
    emailTextField.translatesAutoresizingMaskIntoConstraints = false
    //    emailTextField.addTarget(self, action: #selector(validateEmail), for: .editingChanged)
  }
  
  func settingPasswordTextField() {
    passwordTextField.placeholderColor = .TextGrayColor
    passwordTextField.borderInactiveColor = .LightGrayColor
    passwordTextField.borderActiveColor = .MainGreenColor
    passwordTextField.textColor = .TextGrayColor
    passwordTextField.placeholder = "Укажите ваш пароль"
    passwordTextField.font = UIFont(name: "Helvetica", size: 16)
    passwordTextField.placeholderFontScale = 1
    passwordTextField.keyboardType = .default
    passwordTextField.translatesAutoresizingMaskIntoConstraints = false
    //    passwordTextField.addTarget(self, action: #selector(validateEmail), for: .editingChanged)
  }

  
  func setingUI() {
    view.addSubview(emailTextField)
    view.addSubview(passwordTextField)
    view.addSubview(editLabel)
    
    editLabel.topAnchor.constraint(equalTo: view.topAnchor, constant: 40).isActive = true
    editLabel.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 30).isActive = true
    editLabel.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -30).isActive = true
    editLabel.heightAnchor.constraint(equalToConstant: 50).isActive = true
    
    emailTextField.topAnchor.constraint(equalTo: editLabel.bottomAnchor, constant: 30).isActive = true
    emailTextField.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 30).isActive = true
    emailTextField.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -30).isActive = true
    emailTextField.heightAnchor.constraint(equalToConstant: 50).isActive = true
    
    passwordTextField.topAnchor.constraint(equalTo: emailTextField.bottomAnchor, constant: 10).isActive = true
    passwordTextField.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 30).isActive = true
    passwordTextField.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -30).isActive = true
    passwordTextField.heightAnchor.constraint(equalToConstant: 50).isActive = true
  }
  
}
