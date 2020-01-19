//
//  DrawerContentViewController.swift
//  notes
//
//  Created by Pavel Anpleenko on 13.01.2020.
//  Copyright © 2020 Pavel Anpleenko. All rights reserved.
//

import UIKit
import TextFieldEffects
import Firebase

class ResetPasswordViewController: UIViewController {
  
  let emailTextField = HoshiTextField()
  
  let resetLabel: UILabel = {
    let label = UILabel()
    label.font = UIFont.boldSystemFont(ofSize: 20)
    label.textAlignment = .center
    label.translatesAutoresizingMaskIntoConstraints = false
    label.text = "Сброс пароля"
    label.textColor = .TextGrayColor
    label.lineBreakMode = .byWordWrapping
    return label
  }()
  
  let resetButton: UIButton = {
    let button = UIButton()
    button.titleColor(for: .normal)
    button.backgroundColor = .LightGrayColor
    button.translatesAutoresizingMaskIntoConstraints = false
    button.layer.cornerRadius = 25
    button.setTitle("Сбросить пароль", for: .normal)
    button.isEnabled = false
    button.addTarget(self, action: #selector(resetButtonAction), for: .touchUpInside)
    return button
  }()
  
  override func viewDidLoad() {
    super.viewDidLoad()
    view.backgroundColor = .white

    emailTextField.placeholderColor = .TextGrayColor
    emailTextField.borderInactiveColor = .LightGrayColor
    emailTextField.borderActiveColor = .MainGreenColor
    emailTextField.textColor = .TextGrayColor
    emailTextField.placeholder = "Укажите ваш Email"
    emailTextField.font = UIFont(name: "Helvetica", size: 16)
    emailTextField.placeholderFontScale = 1
    emailTextField.keyboardType = .emailAddress
    emailTextField.translatesAutoresizingMaskIntoConstraints = false
    emailTextField.addTarget(self, action: #selector(validateEmail), for: .editingChanged)
    
    view.addSubview(emailTextField)
    view.addSubview(resetLabel)
    view.addSubview(resetButton)
    
    resetLabel.topAnchor.constraint(equalTo: view.topAnchor, constant: 40).isActive = true
    resetLabel.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 30).isActive = true
    resetLabel.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -30).isActive = true
    resetLabel.heightAnchor.constraint(equalToConstant: 50).isActive = true
    
    emailTextField.topAnchor.constraint(equalTo: resetLabel.bottomAnchor, constant: 30).isActive = true
    emailTextField.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 30).isActive = true
    emailTextField.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -30).isActive = true
    emailTextField.heightAnchor.constraint(equalToConstant: 50).isActive = true
    
    resetButton.topAnchor.constraint(equalTo: emailTextField.bottomAnchor, constant: 40).isActive = true
    resetButton.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 30).isActive = true
    resetButton.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -30).isActive = true
    resetButton.heightAnchor.constraint(equalToConstant: 50).isActive = true
  }

  @objc func validateEmail() {
    guard let finalResult = emailTextField.text?.isValid(.email) else {return}
    if finalResult == true {
      resetButton.isEnabled = true
      resetButton.backgroundColor = .LightOrangeColor
    }
    print(finalResult)
  }
  
  @objc func resetButtonAction() {
    guard let email = emailTextField.text else { return }
    Auth.auth().sendPasswordReset(withEmail: email, completion: { (error) in
      //Make sure you execute the following code on the main queue
      DispatchQueue.main.async {
        //Use "if let" to access the error, if it is non-nil
        if let error = error {
          let resetFailedAlert = UIAlertController(title: "Ошибка сброса пароля!", message: "По непонятным причинам сбросить пароль невозможно. Ошибка: \(error.localizedDescription).", preferredStyle: .alert)
          resetFailedAlert.addAction(UIAlertAction(title: "Попробую позже", style: .default, handler: nil))
          self.present(resetFailedAlert, animated: true, completion: nil)
        } else {
          let resetEmailSentAlert = UIAlertController(title: "Пароль успешно сброшен!", message: "На указаный указаный Вами адрес(\(email)) придёт письмо с инструкциями.", preferredStyle: .alert)
          resetEmailSentAlert.addAction(UIAlertAction(title: "Отлично", style: .default, handler: nil))
          self.present(resetEmailSentAlert, animated: true, completion: nil)
        }
      }
    })
    
  }
  
}
