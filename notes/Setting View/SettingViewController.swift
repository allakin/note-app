//
//  sdfsdfsdfadasdads.swift
//  notes
//
//  Created by Pavel Anpleenko on 28.01.2020.
//  Copyright © 2020 Pavel Anpleenko. All rights reserved.
//

import UIKit
import FirebaseAuth
import FittedSheets

class SettingViewController: UIViewController {
  
  @IBOutlet weak var addUserPhoto: UIButton!
  @IBOutlet weak var userAvatar: UIImageView!
  
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
  
  let editUserSetting: UIButton = {
    let button = UIButton()
    button.translatesAutoresizingMaskIntoConstraints = false
    button.backgroundColor = .MainGreenColor
    button.setTitle("Изменить настройки", for: .normal)
    button.tintColor = .white
    button.titleLabel?.textAlignment = .center
    button.layer.cornerRadius = 25
    button.addTarget(self, action: #selector(editButtonAction), for: .touchUpInside)
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
    getData()
    addUserPhoto.layer.shadowColor = UIColor.LightOrangeColor.cgColor
    addUserPhoto.layer.shadowOpacity = 1
    addUserPhoto.layer.shadowOffset = .init(width: 0, height: 7)
    addUserPhoto.layer.shadowRadius = 7
    uiSetting()
  }
  
  //FIXME: Поправить редактирование профиля пользователя
  @objc func editButtonAction() {
    print("asd")
    let controller = ResetPasswordViewController()
    let sheetController = SheetViewController(controller: controller)
    sheetController.handleColor = UIColor.white
    sheetController.topCornersRadius = 25
    sheetController.handleSize = CGSize(width: 50, height: 4)
    sheetController.setSizes([.fixed(400)], animated: true)
    // It is important to set animated to false or it behaves weird currently
    self.present(sheetController, animated: false, completion: nil)
  }
  
  func getData() {
    Reference().correctReference().child(FirebaseEntity.personInformation.rawValue)
      .child(Reference().returnUserID()).observeSingleEvent(of: .value, with: { (snapshot) in
        guard let dictionary = snapshot.value as? NSDictionary else {return}
        if let username = dictionary["PersonName"] as? String,
          let userSecondName = dictionary["PersonSecondName"] as? String,
          let userEmail = dictionary["UserEmail"] as? String {
          self.userNameLabel.text = "\(username) \(userSecondName)"
          self.userEmailLabel.text = "\(userEmail)"
        }
      }) { (error) in
        print(error.localizedDescription)
    }
  }
  
  @objc func logoutButtonAction() {
    do{
      try Auth.auth().signOut()
      self.userDefault.set(false, forKey: "stateCheckbox")
      let startScreen = self.storyboard?.instantiateViewController(withIdentifier: "StartScreenViewController") as! StartScreenViewController
      startScreen.modalPresentationStyle = .fullScreen
      self.present(startScreen, animated: true, completion: nil)
    } catch let logoutError {
      print(logoutError)
    }
    print(userDefault.bool(forKey: "stateCheckbox"))
    
  }
  
  func returnUserDefaultString(string: String) -> String {
    return userDefault.string(forKey: string) ?? ""
  }
  
  @IBAction func addUserPhotoButtonAction(_ sender: Any) {
    showAlert()
  }
  
  func uiSetting() {
    view.addSubview(userNameLabel)
    view.addSubview(userEmailLabel)
    view.addSubview(logoutButton)
    view.addSubview(editUserSetting)
    
    userNameLabel.topAnchor.constraint(equalTo: addUserPhoto.bottomAnchor, constant: 20).isActive = true
    userNameLabel.leftAnchor.constraint(equalTo: view.leftAnchor).isActive = true
    userNameLabel.rightAnchor.constraint(equalTo: view.rightAnchor).isActive = true
    userNameLabel.heightAnchor.constraint(equalToConstant: 60).isActive = true
    
    userEmailLabel.topAnchor.constraint(equalTo: userNameLabel.bottomAnchor, constant: -20).isActive = true
    userEmailLabel.leftAnchor.constraint(equalTo: view.leftAnchor).isActive = true
    userEmailLabel.rightAnchor.constraint(equalTo: view.rightAnchor).isActive = true
    userEmailLabel.heightAnchor.constraint(equalToConstant: 60).isActive = true
    
    editUserSetting.topAnchor.constraint(equalTo: userEmailLabel.bottomAnchor, constant: 20).isActive = true
    editUserSetting.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 50).isActive = true
    editUserSetting.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -50).isActive = true
    editUserSetting.heightAnchor.constraint(equalToConstant: 50).isActive = true
    
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


extension SettingViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
  //get a photo
  func showAlert() {
    let alert = UIAlertController(title: "Укажите место", message: "Где хранятся ваши фотографии", preferredStyle: .actionSheet)
    alert.addAction(UIAlertAction(title: "Камера", style: .default, handler: {(action: UIAlertAction) in
      self.getImage(fromSourceType: .camera)
    }))
    alert.addAction(UIAlertAction(title: "Альбом", style: .default, handler: {(action: UIAlertAction) in
      self.getImage(fromSourceType: .photoLibrary)
    }))
    alert.addAction(UIAlertAction(title: "Cancel", style: .default, handler: nil))
    self.present(alert, animated: true, completion: nil)
  }
  
  //get image from source type
  func getImage(fromSourceType sourceType: UIImagePickerController.SourceType) {
    //Check is source type available
    if UIImagePickerController.isSourceTypeAvailable(sourceType) {
      let imagePickerController = UIImagePickerController()
      imagePickerController.delegate = self
      imagePickerController.sourceType = sourceType
      self.present(imagePickerController, animated: true, completion: nil)
    }
  }
  
  func imagePickerController(_ picker: UIImagePickerController,
                             didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
    picker.dismiss(animated: true, completion: nil)
    if let image = info[UIImagePickerController.InfoKey.originalImage] as? UIImage {
      userAvatar.image = image
    }
  }
  //<-end
}
