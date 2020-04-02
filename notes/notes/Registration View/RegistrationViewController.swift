//
//  RegistrationViewController.swift
//  notes
//
//  Created by Pavel Anpleenko on 05/10/2019.
//  Copyright © 2019 Pavel Anpleenko. All rights reserved.
//

import UIKit
import TextFieldEffects
import FirebaseAuth
import FirebaseFirestore

class RegistrationViewController: UIViewController {

  @IBOutlet weak var textLabel: UILabel!
  @IBOutlet weak var registrationButton: UIButton!
  
  let emailTextField = HoshiTextField()
  let passwordTextField = HoshiTextField()
  let firstNameTextField = HoshiTextField()
  let lastNameTextField = HoshiTextField()
  var emailValidState = false
  var passwordValidState = false
  let userDefault = UserDefaults.standard
  
  override func viewDidLoad() {
    super.viewDidLoad()
    view.overrideUserInterfaceStyle = .light
    setingEmailField()
    setingUIElements()
  }
  
  var passwordText: UILabel = {
    let text = UILabel()
    text.text = "Минимальный пароль 10 символов. Например: 123456789A или qwertyui1."
    text.font = UIFont(name: "Helvetica", size: 14)
    text.tintColor = .gray
    text.alpha = 0.5
    text.translatesAutoresizingMaskIntoConstraints = false
    text.numberOfLines = 3
    text.lineBreakMode = .byWordWrapping
    return text
  }()
  
  var showPasswordButton: UIButton = {
    let button = UIButton()
    button.translatesAutoresizingMaskIntoConstraints = false
    button.backgroundColor = .clear
    button.layer.cornerRadius = 25
    button.setImage(UIImage(systemName: "eye"), for: .normal)
    button.tintColor = .LightOrangeColor
    button.addTarget(self, action: #selector(showPasswordButtonActive), for: .touchUpInside)
    return button
  }()
  
  @objc func showPasswordButtonActive() {
    if passwordTextField.isSecureTextEntry == true {
      passwordTextField.isSecureTextEntry = false
      showPasswordButton.setImage(UIImage(systemName: "eye.fill"), for: .normal)
    } else {
      passwordTextField.isSecureTextEntry = true
      showPasswordButton.setImage(UIImage(systemName: "eye"), for: .normal)
    }
  }
  
  func setingEmailField() {
    view.addSubview(firstNameTextField)
    view.addSubview(lastNameTextField)
    view.addSubview(emailTextField)
    view.addSubview(passwordTextField)
    view.addSubview(showPasswordButton)
    view.addSubview(passwordText)
    
    emailTextField.placeholderColor = .TextGrayColor
    emailTextField.borderInactiveColor = .LightGrayColor
    emailTextField.borderActiveColor = .LightBlueColor
    emailTextField.placeholder = "Email"
    emailTextField.placeholderFontScale = 1
    emailTextField.font = UIFont(name: "Helvetica", size: 16)
    emailTextField.keyboardType = .emailAddress
    emailTextField.translatesAutoresizingMaskIntoConstraints = false
    
    passwordTextField.placeholderColor = .TextGrayColor
    passwordTextField.borderInactiveColor = .LightGrayColor
    passwordTextField.borderActiveColor = .LightBlueColor
    passwordTextField.placeholder = "Пароль"
    passwordTextField.placeholderFontScale = 1
		passwordTextField.isSecureTextEntry = true
    passwordTextField.font = UIFont(name: "Helvetica", size: 16)
    passwordTextField.translatesAutoresizingMaskIntoConstraints = false
    
    firstNameTextField.placeholderColor = .TextGrayColor
    firstNameTextField.borderInactiveColor = .LightGrayColor
    firstNameTextField.borderActiveColor = .LightBlueColor
    firstNameTextField.placeholder = "Имя пользователя"
    firstNameTextField.placeholderFontScale = 1
    firstNameTextField.font = UIFont(name: "Helvetica", size: 16)
    firstNameTextField.translatesAutoresizingMaskIntoConstraints = false
    
    lastNameTextField.placeholderColor = .TextGrayColor
    lastNameTextField.borderInactiveColor = .LightGrayColor
    lastNameTextField.borderActiveColor = .LightBlueColor
    lastNameTextField.placeholder = "Фамилия пользователя"
    lastNameTextField.placeholderFontScale = 1
    lastNameTextField.font = UIFont(name: "Helvetica", size: 16)
    lastNameTextField.translatesAutoresizingMaskIntoConstraints = false
    
    emailTextField.addTarget(self, action: #selector(validateEmail), for: .editingChanged)
    passwordTextField.addTarget(self, action: #selector(validatePassword), for: .editingChanged)
  }
  
  func setingUIElements() {
    firstNameTextField.topAnchor.constraint(equalTo: textLabel.bottomAnchor, constant: 40).isActive = true
    firstNameTextField.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 30).isActive = true
    firstNameTextField.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -30).isActive = true
    firstNameTextField.heightAnchor.constraint(equalToConstant: 50).isActive = true
    
    lastNameTextField.topAnchor.constraint(equalTo: firstNameTextField.bottomAnchor, constant: 40).isActive = true
    lastNameTextField.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 30).isActive = true
    lastNameTextField.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -30).isActive = true
    lastNameTextField.heightAnchor.constraint(equalToConstant: 50).isActive = true
    
    emailTextField.topAnchor.constraint(equalTo: lastNameTextField.bottomAnchor, constant: 40).isActive = true
    emailTextField.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 30).isActive = true
    emailTextField.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -30).isActive = true
    emailTextField.heightAnchor.constraint(equalToConstant: 50).isActive = true
    
    passwordTextField.topAnchor.constraint(equalTo: emailTextField.bottomAnchor, constant: 40).isActive = true
    passwordTextField.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 30).isActive = true
    passwordTextField.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -30).isActive = true
    passwordTextField.heightAnchor.constraint(equalToConstant: 50).isActive = true
    
    passwordText.topAnchor.constraint(equalTo: passwordTextField.bottomAnchor, constant: 10).isActive = true
    passwordText.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 30).isActive = true
    passwordText.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -30).isActive = true
    
    showPasswordButton.topAnchor.constraint(equalTo: emailTextField.bottomAnchor, constant: 54).isActive = true
    showPasswordButton.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -30).isActive = true
    showPasswordButton.heightAnchor.constraint(equalToConstant: 40).isActive = true
    showPasswordButton.widthAnchor.constraint(equalToConstant: 40).isActive = true
  }

  @objc func validateEmail() {
		guard let email = emailTextField.text else { return }
    if emailTextField.returnValidEmail(textField: emailTextField, email: email) == true {
      emailTextField.borderActiveColor = .MainGreenColor
			emailValidState = true
			correctFormWithRegistrationInformation()
		} else{
			emailTextField.borderActiveColor = .red
		}
		print(emailTextField.returnValidEmail(textField: emailTextField, email: email))
   }
   
   @objc func validatePassword() {

		guard let password = passwordTextField.text else { return }
    if passwordTextField.returnValidPassword(textField: passwordTextField, password: password) == true {
      passwordTextField.borderActiveColor = .MainGreenColor
			passwordValidState = true
			correctFormWithRegistrationInformation()
		} else{
			passwordTextField.borderActiveColor = .red
		}
		print(emailTextField.returnValidPassword(textField: passwordTextField, password: password))
   }
  
  func correctFormWithRegistrationInformation() {
    if emailValidState == true && passwordValidState == true {
         registrationButton.isEnabled = true
         registrationButton.backgroundColor = .LightOrangeColor
         registrationButton.alpha = 1
       }
  }
  
  func validateFields() -> String {
    //проверка полей на заполненость
    
    if firstNameTextField.text?.trimmingCharacters(in: .whitespacesAndNewlines) == "" ||
      lastNameTextField.text?.trimmingCharacters(in: .whitespacesAndNewlines) == "" ||
      emailTextField.text?.trimmingCharacters(in: .whitespacesAndNewlines) == "" ||
      passwordTextField.text?.trimmingCharacters(in: .whitespacesAndNewlines) == "" {
        return "Please fill in all fields"
    }
    return ""
  }
  
  @IBAction func signUpTapped(_ sender: Any) {
    //Validate the fields
    let error = validateFields()
    if error != "" && emailValidState != false && passwordValidState != false {
      print("Error Text Filed")
    } else {
      guard let firstName = firstNameTextField.text, let lastName = lastNameTextField.text,
        let email = emailTextField.text, let password = passwordTextField.text else {return}
      
      Auth.auth().createUser(withEmail: email, password: password) { (results, error) in
				var usedAccount = false
				if error != nil {
					usedAccount = true
					print(error?.localizedDescription)
        }
				
				if usedAccount == false {
					self.view.activityStartAnimating(activityColor: .LightOrangeColor, alpha: 0.6)
					let keyID = Reference().returnUserID()
					let data = [StoreKeyList().getKeyFromStore(key: .personName): firstName,
											StoreKeyList().getKeyFromStore(key: .personSecondName): lastName,
											StoreKeyList().getKeyFromStore(key: .userEmail): email] as [String : Any]
					Reference().correctReference().child(StoreKeysFirebaseEntity().getEntityKeyFromFirebase(key: .personInformation)).child(keyID ?? "").setValue(data)
					
					//Transition to the home screen
					let registration = self.storyboard?.instantiateViewController(withIdentifier: "ContainerViewController") as! ContainerViewController
					registration.modalPresentationStyle = .fullScreen
					self.present(registration, animated: true, completion: nil)
					self.view.activityStopAnimating()
					print("User was create successfully")
				} else {
					let alert = UIAlertController(title: "Ошибка!", message: "Аккаунт с таким email занят, просьба ввести другой E-mail адрес или попробуйте сбросить пароль.", preferredStyle: .alert)
					let action = UIAlertAction(title: "OK", style: .default, handler: nil)
					alert.addAction(action)
					self.present(alert, animated: true, completion: nil)
					self.emailTextField.borderInactiveColor = .red
					self.emailTextField.borderActiveColor = .red
				}
				
      }

    }
  }
	
  @IBAction func cancelTapped(_ sender: Any) {
    dismiss(animated: true, completion: nil)
  }
}
