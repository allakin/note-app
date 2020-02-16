//
//  sdfsdfsdfadasdads.swift
//  notes
//
//  Created by Pavel Anpleenko on 28.01.2020.
//  Copyright © 2020 Pavel Anpleenko. All rights reserved.
//

import UIKit
import FirebaseAuth

class SettingViewController: UIViewController {
  
  @IBOutlet weak var addUserPhoto: UIButton!
  
  let userDefault = UserDefaults.standard
  
  let userNameLabel: UILabel = {
    let label = UILabel()
    label.text = "Имя Фамилия"
    label.textAlignment = .center
    label.font = UIFont(name: "Helvetica", size: 25)
    label.font = UIFont.boldSystemFont(ofSize: 25)
    label.textColor = .TextGrayColor
    label.translatesAutoresizingMaskIntoConstraints = false
    return label
  }()
  
  let logoutButton: UIButton = {
    let button = UIButton()
    button.translatesAutoresizingMaskIntoConstraints = false
    button.backgroundColor = .LightOrangeColor
    button.setTitle("Сменить пользователя", for: .normal)
    button.setTitleColor(.white, for: .normal)
    button.layer.cornerRadius = 25
    button.addTarget(self, action: #selector(logoutButtonAction), for: .touchUpInside)
    return button
  }()
  
  let userEmailLabel: UILabel = {
    let label = UILabel()
    label.text = "admin@mail.ru"
    label.textAlignment = .center
    label.font = UIFont(name: "Helvetica", size: 18)
    label.textColor = .TextGrayColor
    label.translatesAutoresizingMaskIntoConstraints = false
    return label
  }()
  
  
  override func viewDidLoad() {
    super.viewDidLoad()
    view.backgroundColor = .white
    userNameLabel.text = "\(returnUserDefaultString(string: "userName")) \(returnUserDefaultString(string: "lastName"))"
    userEmailLabel.text = "\(returnUserDefaultString(string: "userEmail"))"
    addUserPhoto.layer.shadowColor = UIColor.LightOrangeColor.cgColor
    addUserPhoto.layer.shadowOpacity = 1
    addUserPhoto.layer.shadowOffset = .init(width: 0, height: 7)
    addUserPhoto.layer.shadowRadius = 7
    uiSetting()
  }
  
  @objc func logoutButtonAction() {
    do{
      try Auth.auth().signOut()
      self.userDefault.set(false, forKey: "stateCheckbox")
      self.userDefault.removeObject(forKey: "userLogin")
      self.userDefault.removeObject(forKey: "userPassword")
      self.userDefault.removeObject(forKey: "userName")
      self.userDefault.removeObject(forKey: "lastName")
      self.userDefault.removeObject(forKey: "userEmail")
      let startScreen = self.storyboard?.instantiateViewController(withIdentifier: "StartScreenViewController") as! StartScreenViewController
      startScreen.modalPresentationStyle = .fullScreen
      self.present(startScreen, animated: true, completion: nil)
    } catch let logoutError {
      print(logoutError)
    }
    
    print("++++++++++++")
    print(userDefault.bool(forKey: "stateCheckbox"))
    
  }
  
  func returnUserDefaultString(string: String) -> String {
    return userDefault.string(forKey: string) ?? ""
  }
  
  func uiSetting() {
    view.addSubview(userNameLabel)
    view.addSubview(userEmailLabel)
    view.addSubview(logoutButton)
    
    userNameLabel.topAnchor.constraint(equalTo: addUserPhoto.bottomAnchor, constant: 20).isActive = true
    userNameLabel.leftAnchor.constraint(equalTo: view.leftAnchor).isActive = true
    userNameLabel.rightAnchor.constraint(equalTo: view.rightAnchor).isActive = true
    userNameLabel.heightAnchor.constraint(equalToConstant: 60).isActive = true
    
    userEmailLabel.topAnchor.constraint(equalTo: userNameLabel.bottomAnchor, constant: -20).isActive = true
    userEmailLabel.leftAnchor.constraint(equalTo: view.leftAnchor).isActive = true
    userEmailLabel.rightAnchor.constraint(equalTo: view.rightAnchor).isActive = true
    userEmailLabel.heightAnchor.constraint(equalToConstant: 60).isActive = true
    
    logoutButton.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -50).isActive = true
    logoutButton.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 30).isActive = true
    logoutButton.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -30).isActive = true
    logoutButton.heightAnchor.constraint(equalToConstant: 50).isActive = true
  }
  
  /*
   // MARK: - Navigation
   
   // In a storyboard-based application, you will often want to do a little preparation before navigation
   override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
   // Get the new view controller using segue.destination.
   // Pass the selected object to the new view controller.
   }
   */
  
}
