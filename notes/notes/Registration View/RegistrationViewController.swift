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
  
  func setingEmailField() {
    view.addSubview(firstNameTextField)
    view.addSubview(lastNameTextField)
    view.addSubview(emailTextField)
    view.addSubview(passwordTextField)
    
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
  }

  @objc func validateEmail() {
    guard let finalResult = emailTextField.text?.isValid(.email) else {return}
    emailValidState = finalResult
    if finalResult == true {
      emailTextField.borderActiveColor = .MainGreenColor
      correctFormWithLoginInformation()
    }
    print(finalResult)
   }
   
   @objc func validatePassword() {
    guard let finalResult = passwordTextField.text?.isValid(.password) else {return}
    passwordValidState = finalResult
    if finalResult == true {
      passwordTextField.borderActiveColor = .MainGreenColor
      correctFormWithLoginInformation()
    }
    print(finalResult)
   }
  
  func correctFormWithLoginInformation() {
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
    view.activityStartAnimating(activityColor: .LightOrangeColor, alpha: 0.6)
    //Validate the fields
    let error = validateFields()
    if error != "" && emailValidState != false && passwordValidState != false {
      print("Error Text Filed")
    } else {
      guard let firstName = firstNameTextField.text, let lastName = lastNameTextField.text,
        let email = emailTextField.text, let password = passwordTextField.text else {return}
      
      Auth.auth().createUser(withEmail: email, password: password) { (results, err) in
        if err != nil {
          print("Error creating user")
        } else {
          
          let keyID = Reference().returnUserID()
          let data = [StoreKey.personName.rawValue: firstName,
                      StoreKey.personSecondName.rawValue: lastName,
                      StoreKey.userEmail.rawValue: email] as [String : Any]
          Reference().correctReference().child(FirebaseEntity.personInformation.rawValue).child(keyID ?? "").setValue(data)
          
          //Transition to the home screen
          
          DispatchQueue.main.async {
            let registration = self.storyboard?.instantiateViewController(withIdentifier: "ContainerViewController") as! ContainerViewController
            registration.modalPresentationStyle = .fullScreen
            self.present(registration, animated: true, completion: nil)
            self.view.activityStopAnimating()
            print("User was create successfully")
          }
        }
      }

    }
  }
	
  @IBAction func cancelTapped(_ sender: Any) {
    dismiss(animated: true, completion: nil)
  }
}
