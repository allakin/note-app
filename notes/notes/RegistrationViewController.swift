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
  
  let emailTextField = HoshiTextField()
  let passwordTextField = HoshiTextField()
  let firstNameTextField = HoshiTextField()
  let lastNameTextField = HoshiTextField()
  var emailValidState = false
  var passwordValidState = false
  
  override func viewDidLoad() {
    super.viewDidLoad()
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
    emailTextField.borderActiveColor = .MainGreenColor
    emailTextField.placeholder = "Логин"
    emailTextField.placeholderFontScale = 1
    emailTextField.keyboardType = .emailAddress
    emailTextField.translatesAutoresizingMaskIntoConstraints = false
    
    passwordTextField.placeholderColor = .TextGrayColor
    passwordTextField.borderInactiveColor = .LightGrayColor
    passwordTextField.borderActiveColor = .MainGreenColor
    passwordTextField.placeholder = "Пароль"
    passwordTextField.placeholderFontScale = 1
    passwordTextField.translatesAutoresizingMaskIntoConstraints = false
    
    firstNameTextField.placeholderColor = .TextGrayColor
    firstNameTextField.borderInactiveColor = .LightGrayColor
    firstNameTextField.borderActiveColor = .MainGreenColor
    firstNameTextField.placeholder = "Имя пользователя"
    firstNameTextField.placeholderFontScale = 1
    firstNameTextField.translatesAutoresizingMaskIntoConstraints = false
    
    lastNameTextField.placeholderColor = .TextGrayColor
    lastNameTextField.borderInactiveColor = .LightGrayColor
    lastNameTextField.borderActiveColor = .MainGreenColor
    lastNameTextField.placeholder = "Фамилию пользователя"
    lastNameTextField.placeholderFontScale = 1
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
    print(finalResult)
   }
   
   @objc func validatePassword() {
    guard let finalResult = passwordTextField.text?.isValid(.password) else {return}
    passwordValidState = finalResult
    print(finalResult)
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
    if error != "" && emailValidState != false && passwordValidState != false{
      print("Error Text Filed")
    } else {
      guard let firstName = firstNameTextField.text, let lastName = lastNameTextField.text,
        let email = emailTextField.text, let password = passwordTextField.text else {return}

      firstName.trimmingCharacters(in: .whitespacesAndNewlines)
      lastName.trimmingCharacters(in: .whitespacesAndNewlines)
      email.trimmingCharacters(in: .whitespacesAndNewlines)
      password.trimmingCharacters(in: .whitespacesAndNewlines)
      
      let note_image_cover = ""
      let note_title = ""
      let note_description = ""
      
      
      Auth.auth().createUser(withEmail: email, password: password) { (results, err) in
        if err != nil {
          print("Error creating user")
        } else {
          //Create the user
          let db = Firestore.firestore()
          db.collection("users").addDocument(data: ["first_name" : firstName,
                                                    "last_name" : lastName,
                                                    "uid": results!.user.uid,
                                                    "notes": ["note_image_cover": "Привет!",
                                                             "note_title": "Как дела?",
                                                             "note_description": "ДА ДА"]]) { (error) in
            if error != nil {
              print("user data couldn't save")
            }
          }
          //Transition to the home screen
          
          DispatchQueue.main.async {
            let registration = self.storyboard?.instantiateViewController(withIdentifier: "NotesCatalogCollectionViewController") as! NotesCatalogCollectionViewController
            registration.modalPresentationStyle = .fullScreen
            self.present(registration, animated: true, completion: nil)
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
