//
//  MenuViewController.swift
//  notes
//
//  Created by Pavel Anpleenko on 20.01.2020.
//  Copyright © 2020 Pavel Anpleenko. All rights reserved.
//

import UIKit

protocol MenuViewControllerDelegate {
  func closeMenu()
  func openSettingView()
  func openSupportView()
}

class MenuViewController: UIViewController {
  
  var delegate: MenuViewControllerDelegate?
  var controller: UIViewController!
  
  let closeMenuButton: UIButton = {
    let button = UIButton()
    button.backgroundColor = .clear
    button.translatesAutoresizingMaskIntoConstraints = false
    button.layer.cornerRadius = 25
    button.setImage(#imageLiteral(resourceName: "close_menu"), for: .normal)
    button.addTarget(self, action: #selector(closeMenuButtonAction), for: .touchUpInside)
    return button
  }()
  
  let noteMenuButton: UIButton = {
    let button = UIButton()
    button.backgroundColor = .clear
    button.translatesAutoresizingMaskIntoConstraints = false
    button.layer.cornerRadius = 25
    button.setTitle("Заметки", for: .normal)
    button.titleLabel?.textAlignment = .center
    button.tintColor = .TextGrayColor
    button.titleLabel?.font = UIFont(name: "Helvetica", size: 22)
    button.addTarget(self, action: #selector(openNoteView), for: .touchUpInside)
    return button
  }()
  
  let supportMenuButton: UIButton = {
    let button = UIButton()
    button.backgroundColor = .clear
    button.translatesAutoresizingMaskIntoConstraints = false
    button.layer.cornerRadius = 25
    button.setTitle("Поддержка", for: .normal)
    button.titleLabel?.textAlignment = .center
    button.tintColor = .TextGrayColor
    button.titleLabel?.font = UIFont(name: "Helvetica", size: 22)
    button.addTarget(self, action: #selector(supportView), for: .touchUpInside)
    return button
  }()
  
  let settingMenuButton: UIButton = {
    let button = UIButton()
    button.backgroundColor = .clear
    button.translatesAutoresizingMaskIntoConstraints = false
    button.layer.cornerRadius = 25
    button.setTitle("Настройки", for: .normal)
    button.titleLabel?.textAlignment = .center
    button.tintColor = .TextGrayColor
    button.titleLabel?.font = UIFont(name: "Helvetica", size: 22)
    button.addTarget(self, action: #selector(settingView), for: .touchUpInside)
    return button
  }()
  
  let activeButtonNote: UIView = {
    let view = UIView()
    view.backgroundColor = .white
    view.translatesAutoresizingMaskIntoConstraints = false
    return view
  }()
  
  let activeButtonSupport: UIView = {
    let view = UIView()
    view.backgroundColor = .white
    view.translatesAutoresizingMaskIntoConstraints = false
    return view
  }()
  
  let activeButtonSetting: UIView = {
    let view = UIView()
    view.backgroundColor = .white
    view.translatesAutoresizingMaskIntoConstraints = false
    return view
  }()
  
  override func viewDidLoad() {
    super.viewDidLoad()
    view.backgroundColor = #colorLiteral(red: 0.2312145531, green: 0.8206946254, blue: 0.6177207232, alpha: 1)
    uiSetting()
    activeButtonSupport.alpha = 0
    activeButtonSetting.alpha = 0
  }
  
  @objc func closeMenuButtonAction() {
    delegate?.closeMenu()
    print("work")
  }
  
  override func viewWillAppear(_ animated: Bool) {
    super.viewWillAppear(animated)
    self.setNeedsStatusBarAppearanceUpdate()
  }
  override var preferredStatusBarStyle: UIStatusBarStyle {
    return .darkContent
  }
  
  @objc func openNoteView() {
    delegate?.closeMenu()
    activeButtonSupport.alpha = 0
    activeButtonSetting.alpha = 0
    activeButtonNote.alpha = 1
    print("Work")
  }
  
  @objc func supportView() {
    delegate?.closeMenu()
    delegate?.openSupportView()
    activeButtonNote.alpha = 0
    activeButtonSetting.alpha = 0
    activeButtonSupport.alpha = 1
    print("Work")
  }
  
  @objc func settingView() {
    delegate?.closeMenu()
    delegate?.openSettingView()
    activeButtonNote.alpha = 0
    activeButtonSetting.alpha = 1
    activeButtonSupport.alpha = 0
    print("Work")
   }
  
  func uiSetting() {
    view.addSubview(closeMenuButton)
    view.addSubview(noteMenuButton)
    view.addSubview(supportMenuButton)
    view.addSubview(activeButtonNote)
    view.addSubview(activeButtonSupport)
    view.addSubview(settingMenuButton)
    view.addSubview(activeButtonSetting)
    
    closeMenuButton.topAnchor.constraint(equalTo: view.topAnchor, constant: 50).isActive = true
    closeMenuButton.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 16).isActive = true
    closeMenuButton.widthAnchor.constraint(equalToConstant: 50).isActive = true
    closeMenuButton.heightAnchor.constraint(equalToConstant: 50).isActive = true
    
    activeButtonNote.topAnchor.constraint(equalTo: closeMenuButton.bottomAnchor, constant: 80).isActive = true
    activeButtonNote.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 0).isActive = true
    activeButtonNote.widthAnchor.constraint(equalToConstant: 4).isActive = true
    activeButtonNote.heightAnchor.constraint(equalToConstant: 50).isActive = true
  
    noteMenuButton.topAnchor.constraint(equalTo: closeMenuButton.bottomAnchor, constant: 80).isActive = true
    noteMenuButton.leftAnchor.constraint(equalTo: activeButtonNote.rightAnchor, constant: 16).isActive = true
    noteMenuButton.widthAnchor.constraint(equalToConstant: 200).isActive = true
    noteMenuButton.heightAnchor.constraint(equalToConstant: 50).isActive = true
    
    activeButtonSupport.topAnchor.constraint(equalTo: activeButtonNote.bottomAnchor, constant: 30).isActive = true
    activeButtonSupport.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 0).isActive = true
    activeButtonSupport.widthAnchor.constraint(equalToConstant: 4).isActive = true
    activeButtonSupport.heightAnchor.constraint(equalToConstant: 50).isActive = true
    
    supportMenuButton.topAnchor.constraint(equalTo: noteMenuButton.bottomAnchor, constant: 30).isActive = true
    supportMenuButton.leftAnchor.constraint(equalTo: activeButtonSupport.rightAnchor, constant: 16).isActive = true
    supportMenuButton.widthAnchor.constraint(equalToConstant: 200).isActive = true
    supportMenuButton.heightAnchor.constraint(equalToConstant: 50).isActive = true
    
    activeButtonSetting.topAnchor.constraint(equalTo: activeButtonSupport.bottomAnchor, constant: 30).isActive = true
    activeButtonSetting.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 0).isActive = true
    activeButtonSetting.widthAnchor.constraint(equalToConstant: 4).isActive = true
    activeButtonSetting.heightAnchor.constraint(equalToConstant: 50).isActive = true
    
    settingMenuButton.topAnchor.constraint(equalTo: supportMenuButton.bottomAnchor, constant: 30).isActive = true
    settingMenuButton.leftAnchor.constraint(equalTo: activeButtonSetting.rightAnchor, constant: 16).isActive = true
    settingMenuButton.widthAnchor.constraint(equalToConstant: 200).isActive = true
    settingMenuButton.heightAnchor.constraint(equalToConstant: 50).isActive = true
    
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
