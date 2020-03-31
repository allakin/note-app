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
  let userDefault = UserDefaults.standard
  var emailCorrect = false
  var passwordCorrect = false
  
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
    view.addSubview(emailTextField)
    view.addSubview(passwordTextField)
    view.addSubview(showPasswordButton)
    
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
    
    showPasswordButton.topAnchor.constraint(equalTo: emailTextField.bottomAnchor, constant: 54).isActive = true
    showPasswordButton.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -30).isActive = true
    showPasswordButton.heightAnchor.constraint(equalToConstant: 40).isActive = true
    showPasswordButton.widthAnchor.constraint(equalToConstant: 40).isActive = true
    
    checkBoxViewContainer.topAnchor.constraint(equalTo: passwordTextField.bottomAnchor, constant: 20).isActive = true
    checkBoxViewContainer.leftAnchor.constraint(equalTo: view.leftAnchor).isActive = true
    checkBoxViewContainer.rightAnchor.constraint(equalTo: view.rightAnchor).isActive = true
    checkBoxViewContainer.heightAnchor.constraint(equalToConstant: 47).isActive = true
  }
  
  @objc func validateEmail() {
    guard let email = emailTextField.text else { return }
    if emailTextField.returnValidEmail(textField: emailTextField, email: email) == true {
      emailTextField.borderActiveColor = .MainGreenColor
      emailCorrect = true
      correctFormWithLoginInformation()
    } else{
      emailTextField.borderActiveColor = .red
    }
    print(emailTextField.returnValidEmail(textField: emailTextField, email: email))
  }
  
  override func viewWillAppear(_ animated: Bool) {
    super.viewWillAppear(animated)
    self.setNeedsStatusBarAppearanceUpdate()
  }
  override var preferredStatusBarStyle: UIStatusBarStyle {
    return .darkContent
  }
  
  @objc func validatePassword() {
    guard let password = passwordTextField.text else { return }
    if passwordTextField.returnValidPassword(textField: passwordTextField, password: password) == true {
      passwordTextField.borderActiveColor = .MainGreenColor
      passwordCorrect = true
      correctFormWithLoginInformation()
    } else{
      passwordTextField.borderActiveColor = .red
    }
    print(emailTextField.returnValidPassword(textField: passwordTextField, password: password))
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
  
  func alertError(title: String, message: String, buttonTitle: String) {
    let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
    let action = UIAlertAction(title: buttonTitle, style: .default) { (UIAlertAction) in
      self.userDefault.set(false, forKey: "stateCheckbox")
      self.view.activityStopAnimating()
      self.view.alpha = 1.0
    }
    alert.addAction(action)
    self.present(alert, animated: true, completion: nil)
    self.emailTextField.borderInactiveColor = .red
    self.emailTextField.borderActiveColor = .red
  }
  
  func correctFormWithLoginInformation() {
    if emailCorrect == true && passwordCorrect == true {
      loginButton.isEnabled = true
      loginButton.backgroundColor = .LightOrangeColor
      loginButton.alpha = 1
    }
  }
  
  func userLogin(email: String, password: String) {
    Auth.auth().signIn(withEmail: email, password: password) { (result, error) in
      var errorUserEmail = false
      var errorUserPassword = false
      
      let emailError = "There is no user record corresponding to this identifier. The user may have been deleted."
      let passwordError = "The password is invalid or the user does not have a password."
      
      if error != nil {
        switch error?.localizedDescription {
        case emailError:
          errorUserEmail = true
        case passwordError:
          errorUserPassword = true
        default:
          print("Error in login \(error?.localizedDescription)")
        }
      }
      
      if errorUserPassword == true {
        self.alertError(title: "Ошибка!", message: "Введен не корректный пароль для этого аккакунта.", buttonTitle: "OK")
      } else if errorUserEmail == true {
        self.alertError(title: "Ошибка!", message: "Такого адреса нет в системе. Проверьте введёный email.", buttonTitle: "OK")
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
}
