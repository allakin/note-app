//
//  ContainerViewController.swift
//  notes
//
//  Created by Pavel Anpleenko on 20.01.2020.
//  Copyright © 2020 Pavel Anpleenko. All rights reserved.
//

import UIKit

class ContainerViewController: UIViewController, NotesCatalogCollectionViewControllerDelegate, MenuViewControllerDelegate {
  
  func closeMenu() {
    toggleMenu()
  }
  
  var controller: UIViewController!
  var menuViewController: UIViewController!
  var isMove = false
  
  override func viewDidLoad() {
    super.viewDidLoad()
    configureNoteCollectionViewController()
  }
  
  override func viewWillAppear(_ animated: Bool) {
    super.viewWillAppear(animated)
    self.setNeedsStatusBarAppearanceUpdate()
  }
  
  override var preferredStatusBarStyle: UIStatusBarStyle {
    return .darkContent
  }
  
  func configureNoteCollectionViewController() {
    let noteCollectionView = self.storyboard?.instantiateViewController(withIdentifier: "NotesCatalogCollectionViewController") as! NotesCatalogCollectionViewController
    noteCollectionView.delegate = self
    controller = noteCollectionView
    view.addSubview(controller.view)
    addChild(controller)
  }
  
  func configureMenuNoteCollectionViewController() {
    if menuViewController == nil {
      let menu = MenuViewController()
      menu.delegate = self
      menuViewController = menu
      view.insertSubview(menuViewController.view, at: 0)
      addChild(menuViewController)
    }
  }
  
  func showMenuViewController(shouldMove: Bool) {
    if shouldMove {
      self.controller.view.layer.cornerRadius = 30
      self.controller.view.layer.shadowColor = UIColor(red:0.31, green:0.65, blue:0.49, alpha:1.00).cgColor
      self.controller.view.layer.shadowOpacity = 1
      self.controller.view.layer.shadowOffset = .init(width: -15, height: -15)
      self.controller.view.layer.shadowRadius = 20
      UIView.animate(withDuration: 0.6,
                     delay: 0,
                     usingSpringWithDamping: 0.8,
                     initialSpringVelocity: 0,
                     options: .curveEaseOut,
                     animations: {
                      self.controller.view.frame.origin.x = self.controller.view.frame.width - 140
                      self.controller.view.frame.origin.y = CGFloat(100)
      }) { (finished) in
      }
    } else {
      UIView.animate(withDuration: 0.6,
                     delay: 0,
                     usingSpringWithDamping: 0.8,
                     initialSpringVelocity: 0,
                     options: .curveEaseOut,
                     animations: {
                      self.controller.view.frame.origin.x = 0
                      self.controller.view.frame.origin.y = 0
      }) { (finished) in
      }
    }
  }
  
  func toggleMenu() {
    configureMenuNoteCollectionViewController()
    isMove = !isMove
    showMenuViewController(shouldMove: isMove)
  }
  
}
