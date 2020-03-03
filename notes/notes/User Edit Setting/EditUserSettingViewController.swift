//
//  EditUserSettingViewController.swift
//  notes
//
//  Created by Pavel Anpleenko on 23.02.2020.
//  Copyright © 2020 Pavel Anpleenko. All rights reserved.
//

import UIKit
import TextFieldEffects
import Firebase

class EditUserSettingViewController: UIViewController {
	
  let emailTextField = HoshiTextField()
  let nameTextField = HoshiTextField()
	let secondNameTextField = HoshiTextField()
	var userName = ""
	var userSecondName = ""
  
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
	
	let updateEmail: UIButton = {
		let button = UIButton()
		button.backgroundColor = .LightOrangeColor
		button.setTitle("Обновить", for: .normal)
		button.translatesAutoresizingMaskIntoConstraints = false
		button.layer.cornerRadius = 25
		button.addTarget(self, action: #selector(updateEmailAction), for: .touchUpInside)
		button.tintColor = .white
		return button
	}()
  
	override func viewDidLoad() {
		super.viewDidLoad()
		view.backgroundColor = .white
    settingEmailTextField()
    settingNameTextField()
		settingSecondNameTextField()
    setingUI()
    
	}

	@objc func updateEmailAction() {
		guard let email = emailTextField.text else {return}
		let user = Auth.auth().currentUser
		user?.updateEmail(to: email) { error in
			if let error = error {
				// An error happened.
			} else {
				self.dismiss(animated: true) {
					self.updateDataBase()
				}
			}
		}
	}
	
	func updateDataBase() {
		guard let email = emailTextField.text,
			let name = nameTextField.text,
			let secondName = secondNameTextField.text else { return }
		guard let key = Reference().correctReference()
			.child(StoreKeysFirebaseEntity().getEntityKeyFromFirebase(key: .personInformation))
			.child(Reference().returnUserID()).key else { return }
		let post = [StoreKeyList().getKeyFromStore(key: .personName): name,
								StoreKeyList().getKeyFromStore(key: .personSecondName): secondName,
								StoreKeyList().getKeyFromStore(key: .userEmail): email]
		let childUpdates = ["/\(StoreKeysFirebaseEntity().getEntityKeyFromFirebase(key: .personInformation))/\(key)/": post]
		
		Reference().correctReference().updateChildValues(childUpdates)
		NotificationCenter.default.post(name: NSNotification.Name(rawValue: "refreshUserInformation"), object: nil)
		print("Data Changed")
	}
	
  func settingEmailTextField() {
    emailTextField.placeholderColor = .TextGrayColor
    emailTextField.borderInactiveColor = .LightGrayColor
		emailTextField.borderActiveColor = .MainGreenColor
    emailTextField.textColor = .TextGrayColor
    emailTextField.placeholder = "E-mail"
    emailTextField.font = UIFont(name: "Helvetica", size: 16)
    emailTextField.placeholderFontScale = 1
    emailTextField.keyboardType = .emailAddress
    emailTextField.translatesAutoresizingMaskIntoConstraints = false
		emailTextField.addTarget(self, action: #selector(validateEmail), for: .editingChanged)
  }
  
  func settingNameTextField() {
    nameTextField.placeholderColor = .TextGrayColor
    nameTextField.borderInactiveColor = .LightGrayColor
    nameTextField.borderActiveColor = .MainGreenColor
    nameTextField.textColor = .TextGrayColor
    nameTextField.placeholder = "Имя"
    nameTextField.font = UIFont(name: "Helvetica", size: 16)
    nameTextField.placeholderFontScale = 1
    nameTextField.keyboardType = .default
    nameTextField.translatesAutoresizingMaskIntoConstraints = false
    //    nameTextField.addTarget(self, action: #selector(validateEmail), for: .editingChanged)
  }
	
	@objc func validateEmail() {
    guard let finalResult = emailTextField.text?.isValid(.email) else {return}
    if finalResult == true {
      emailTextField.borderActiveColor = .MainGreenColor
    }
    print(finalResult)
  }
	
	func settingSecondNameTextField() {
    secondNameTextField.placeholderColor = .TextGrayColor
    secondNameTextField.borderInactiveColor = .LightGrayColor
    secondNameTextField.borderActiveColor = .MainGreenColor
    secondNameTextField.textColor = .TextGrayColor
    secondNameTextField.placeholder = "Фамилия"
    secondNameTextField.font = UIFont(name: "Helvetica", size: 16)
    secondNameTextField.placeholderFontScale = 1
    secondNameTextField.keyboardType = .default
    secondNameTextField.translatesAutoresizingMaskIntoConstraints = false
    //    nameTextField.addTarget(self, action: #selector(validateEmail), for: .editingChanged)
  }

  
  func setingUI() {
    view.addSubview(emailTextField)
    view.addSubview(nameTextField)
    view.addSubview(editLabel)
		view.addSubview(updateEmail)
		view.addSubview(secondNameTextField)
    
    editLabel.topAnchor.constraint(equalTo: view.topAnchor, constant: 20).isActive = true
    editLabel.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 30).isActive = true
    editLabel.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -30).isActive = true
    editLabel.heightAnchor.constraint(equalToConstant: 50).isActive = true
    
    emailTextField.topAnchor.constraint(equalTo: editLabel.bottomAnchor, constant: 30).isActive = true
    emailTextField.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 30).isActive = true
    emailTextField.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -30).isActive = true
    emailTextField.heightAnchor.constraint(equalToConstant: 50).isActive = true
    
    nameTextField.topAnchor.constraint(equalTo: emailTextField.bottomAnchor, constant: 30).isActive = true
    nameTextField.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 30).isActive = true
    nameTextField.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -30).isActive = true
    nameTextField.heightAnchor.constraint(equalToConstant: 50).isActive = true
		
		secondNameTextField.topAnchor.constraint(equalTo: nameTextField.bottomAnchor, constant: 30).isActive = true
    secondNameTextField.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 30).isActive = true
    secondNameTextField.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -30).isActive = true
    secondNameTextField.heightAnchor.constraint(equalToConstant: 50).isActive = true
		
		updateEmail.topAnchor.constraint(equalTo: secondNameTextField.bottomAnchor, constant: 30).isActive = true
    updateEmail.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 30).isActive = true
    updateEmail.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -30).isActive = true
    updateEmail.heightAnchor.constraint(equalToConstant: 50).isActive = true
  }
  
}
