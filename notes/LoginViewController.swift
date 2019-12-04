//
//  LoginViewController.swift
//  notes
//
//  Created by Pavel Anpleenko on 29/09/2019.
//  Copyright © 2019 Pavel Anpleenko. All rights reserved.
//

import UIKit
import TextFieldEffects
import FirebaseAuth

class LoginViewController: UIViewController {
  
  @IBOutlet weak var textLabel: UILabel!
  
  let emailTextField = HoshiTextField()
  let passwordTextField = HoshiTextField()
  
  override func viewDidLoad() {
    super.viewDidLoad()
    setingEmailField()
    setingUIElements()
  }
  
  func setingEmailField() {
    view.addSubview(emailTextField)
    view.addSubview(passwordTextField)
    emailTextField.placeholderColor = .TextGrayColor
    emailTextField.borderInactiveColor = .LightGrayColor
    emailTextField.borderActiveColor = .MainGreenColor
    emailTextField.placeholder = "Email"
    emailTextField.placeholderFontScale = 1
    emailTextField.keyboardType = .emailAddress
    emailTextField.translatesAutoresizingMaskIntoConstraints = false
    
    passwordTextField.placeholderColor = .TextGrayColor
    passwordTextField.borderInactiveColor = .LightGrayColor
    passwordTextField.borderActiveColor = .MainGreenColor
    passwordTextField.placeholder = "Пароль"
    passwordTextField.placeholderFontScale = 1
    passwordTextField.translatesAutoresizingMaskIntoConstraints = false
    
    emailTextField.addTarget(self, action: #selector(validateEmail), for: .editingChanged)
    passwordTextField.addTarget(self, action: #selector(validatePassword), for: .editingChanged)
  }
  
  func setingUIElements() {
    emailTextField.topAnchor.constraint(equalTo: textLabel.bottomAnchor, constant: 40).isActive = true
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
    print(finalResult)
  }
  
  @objc func validatePassword() {
    guard let finalResult = passwordTextField.text?.isValid(.password) else {return}
    print(finalResult)
  }
  
  @IBAction func cancelTapped(_ sender: Any) {
    
    dismiss(animated: true, completion: nil)
  }
  @IBAction func signInTapped(_ sender: Any) {
    guard let email = emailTextField.text, let password = passwordTextField.text else {return}
    email.trimmingCharacters(in: .whitespacesAndNewlines)
    password.trimmingCharacters(in: .whitespacesAndNewlines)
    Auth.auth().signIn(withEmail: email, password: password) { (result, error) in
      if error != nil {
        print("Error in login \(error?.localizedDescription)")
      } else {
        DispatchQueue.main.async {
          let registration = self.storyboard?.instantiateViewController(withIdentifier: "NotesCatalogCollectionViewController") as! NotesCatalogCollectionViewController
//          registration.isViewLoaded = true
          registration.modalPresentationStyle = .fullScreen
          self.present(registration, animated: true, completion: nil)
          print("Успешный вход")
        }
      }
    }
  }
}
