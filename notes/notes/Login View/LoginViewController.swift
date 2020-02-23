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
import FittedSheets

class LoginViewController: UIViewController {
  
  @IBOutlet weak var textLabel: UILabel!
  @IBOutlet weak var checkBoxButton: UIButton!
  @IBOutlet weak var checkBoxViewContainer: UIView!
  @IBOutlet weak var loginButton: UIButton!
  
  
  let emailTextField = HoshiTextField()
  let passwordTextField = HoshiTextField()
//  var stateCheckbox = false
  let userDefault = UserDefaults.standard
  var emailCorrect = false
  var passwordCorrect = false
  
  override func viewDidLoad() {
    super.viewDidLoad()
    view.overrideUserInterfaceStyle = .light
    checkBoxViewContainer.translatesAutoresizingMaskIntoConstraints = false
    setingEmailField()
    setingUIElements()
    
    if userDefault.bool(forKey: "stateCheckbox") == false {
      checkboxOFF()
    } else {
      self.view.activityStartAnimating(activityColor: UIColor.LightOrangeColor, alpha: 0.6)
      emailTextField.text = userDefault.string(forKey: "userLogin")
      passwordTextField.text = userDefault.string(forKey: "userPassword")
      checkBoxButton.backgroundColor = UIColor.LightOrangeColor
      
      let userDefaultsUserLogin = userDefault.string(forKey: "userLogin")
      let userDefaultsUserPassword = userDefault.string(forKey: "userPassword")
      guard let email = userDefaultsUserLogin, let password = userDefaultsUserPassword else {return}
      userLogin(email: email, password: password)
    }
    
  }
  
  func setingEmailField() {
    view.addSubview(emailTextField)
    view.addSubview(passwordTextField)
    
    emailTextField.placeholderColor = .TextGrayColor
    emailTextField.borderInactiveColor = .LightGrayColor
    emailTextField.borderActiveColor = .LightBlueColor
    emailTextField.placeholder = "Email"
    emailTextField.font = UIFont(name: "Helvetica", size: 16)
    emailTextField.placeholderFontScale = 1
    emailTextField.keyboardType = .emailAddress
    emailTextField.translatesAutoresizingMaskIntoConstraints = false
    
    passwordTextField.placeholderColor = .TextGrayColor
    passwordTextField.borderInactiveColor = .LightGrayColor
    passwordTextField.borderActiveColor = .LightBlueColor
    passwordTextField.placeholder = "Пароль"
    passwordTextField.font = UIFont(name: "Helvetica", size: 16)
    passwordTextField.placeholderFontScale = 1
    passwordTextField.isSecureTextEntry = true
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
    
    checkBoxViewContainer.topAnchor.constraint(equalTo: passwordTextField.bottomAnchor, constant: 20).isActive = true
    checkBoxViewContainer.leftAnchor.constraint(equalTo: view.leftAnchor).isActive = true
    checkBoxViewContainer.rightAnchor.constraint(equalTo: view.rightAnchor).isActive = true
    checkBoxViewContainer.heightAnchor.constraint(equalToConstant: 47).isActive = true
  }
  
  @objc func validateEmail() {
    guard let finalResult = emailTextField.text?.isValid(.email) else {return}
    emailCorrect = finalResult
    correctFormWithLoginInformation()
    if finalResult == true {
      emailTextField.borderActiveColor = .MainGreenColor
    }
    print(finalResult)
  }
  
  override func viewWillAppear(_ animated: Bool) {
    super.viewWillAppear(animated)
    self.setNeedsStatusBarAppearanceUpdate()
  }
  override var preferredStatusBarStyle: UIStatusBarStyle {
    return .darkContent
  }
  
  @objc func validatePassword() {
    guard let finalResult = passwordTextField.text?.isValid(.password) else {return}
    passwordCorrect = finalResult
    correctFormWithLoginInformation()
    if finalResult == true {
      passwordTextField.borderActiveColor = .MainGreenColor
    }
    print(finalResult)
  }
  
  @IBAction func checkBoxButtonAction(_ sender: Any) {
    if userDefault.bool(forKey: "stateCheckbox") == true {
      checkboxOFF()
      print("Checkbox is false")
    } else {
      checkboxON()
      print("Checkbox is true")
    }
  }
  
  @IBAction func cancelTapped(_ sender: Any) {
    dismiss(animated: true, completion: nil)
  }
  
  @IBAction func signInTapped(_ sender: Any) {
    if userDefault.bool(forKey: "stateCheckbox") == false {
      guard let email = emailTextField.text, let password = passwordTextField.text else {return}
      email.trimmingCharacters(in: .whitespacesAndNewlines)
      password.trimmingCharacters(in: .whitespacesAndNewlines)
      userLogin(email: email, password: password)
    } else {
      let userDefaultsUserLogin = userDefault.string(forKey: "userLogin")
      let userDefaultsUserPassword = userDefault.string(forKey: "userPassword")
      guard let email = userDefaultsUserLogin, let password = userDefaultsUserPassword else {return}
      userLogin(email: email, password: password)
    }
  }
  
  @IBAction func ResetUserPassword(_ sender: Any) {
    let controller = ResetPasswordViewController()
    let sheetController = SheetViewController(controller: controller)
    sheetController.handleColor = UIColor.white
    sheetController.topCornersRadius = 25
    sheetController.handleSize = CGSize(width: 50, height: 4)
    sheetController.setSizes([.fixed(400)], animated: true)
    // It is important to set animated to false or it behaves weird currently
    self.present(sheetController, animated: false, completion: nil)
  }
  
  func userLogin(email: String, password: String) {
    Auth.auth().signIn(withEmail: email, password: password) { (result, error) in
      if error != nil {
        print("Error in login \(error?.localizedDescription)")
      } else {
        DispatchQueue.main.async {
          let login = self.storyboard?.instantiateViewController(withIdentifier: "ContainerViewController") as! ContainerViewController
          login.modalPresentationStyle = .fullScreen
          self.present(login, animated: true, completion: nil)
          print("Успешный вход")
          self.view.activityStopAnimating()
        }
      }
    }
  }
  
  func correctFormWithLoginInformation() {
    if emailCorrect == true && passwordCorrect == true {
         loginButton.isEnabled = true
         loginButton.backgroundColor = .LightOrangeColor
         loginButton.alpha = 1
       }
  }
  
}
