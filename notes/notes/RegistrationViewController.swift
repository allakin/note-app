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
    if error != "" && emailValidState != false && passwordValidState != false{
      print("Error Text Filed")
    } else {
      guard let firstName = firstNameTextField.text, let lastName = lastNameTextField.text,
        let email = emailTextField.text, let password = passwordTextField.text else {return}

//      firstName.trimmingCharacters(in: .whitespacesAndNewlines)
//      lastName.trimmingCharacters(in: .whitespacesAndNewlines)
//      email.trimmingCharacters(in: .whitespacesAndNewlines)
//      password.trimmingCharacters(in: .whitespacesAndNewlines)
      
      Auth.auth().createUser(withEmail: email, password: password) { (results, err) in
        if err != nil {
          print("Error creating user")
        } else {
//          //Create the user
//          let db = Firestore.firestore()
//          db.collection("users").addDocument(data: ["first_name" : firstName,
//                                                    "last_name" : lastName,
//                                                    "uid": results!.user.uid,
//                                                    "notes": ["note_image_cover": "Привет!",
//                                                             "note_title": "Как дела?",
//                                                             "note_description": "ДА ДА"]]) { (error) in
//            if error != nil {
//              print("user data couldn't save")
//            }
//          }
          
          let keyID = Reference().returnUserID()
          let data = [StoreKey.personName.rawValue: firstName,
                      StoreKey.personSecondName.rawValue: lastName,
                      StoreKey.userEmail.rawValue: email] as [String : Any]
          Reference().correctReference().child(FirebaseEntity.personInformation.rawValue).child(keyID ?? "").setValue(data)
          
          //Transition to the home screen
          
          DispatchQueue.main.async {
            let registration = self.storyboard?.instantiateViewController(withIdentifier: "NotesCatalogCollectionViewController") as! NotesCatalogCollectionViewController
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


//func saveDataInFireBase() {
//  guard let title = labelArticle.text,
//    let description = descriptionArticle.text, let image = articleImageCover.image else { return }
//
//  let storageReference = Storage.storage().reference()
//  .child(FirebaseEntity.articlesCoverFolder.rawValue).child("\(image)")
//
//  if let profileImage = self.articleImageCover.image,
//    let uploadData = profileImage.jpegData(compressionQuality: 0.1) {
//
//    storageReference.putData(uploadData, metadata: nil, completion: { (_, error) in
//
//      if let error = error {
//        print(error)
//        return
//      }
//
//      storageReference.downloadURL(completion: { (url, err) in
//        if let err = err {
//          print(err)
//          return
//        }
//
//        guard let url = url else { return }
//        let keyID = Reference().correctReference().childByAutoId().key
//        let data = [StoreKey.labelArticle.rawValue: title,
//                    StoreKey.descriptionArticle.rawValue: description,
//                    StoreKey.articleCoverImage.rawValue: url.absoluteString,
//                    StoreKey.keyID.rawValue: keyID]
//        Reference().correctReference().child(FirebaseEntity.articles.rawValue)
//          .child(Reference().returnUserID()).child(keyID ?? "").setValue(data)
//        NotificationCenter.default.post(name: NSNotification.Name(rawValue: "refreshData"), object: nil)
//        print("Data Saved!")
//      })
//    })
//  }
//}
