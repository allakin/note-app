//
//  NotesCatalogCollectionViewController.swift
//  notes
//
//  Created by Pavel Anpleenko on 10/10/2019.
//  Copyright © 2019 Pavel Anpleenko. All rights reserved.
//

import UIKit
import Firebase

class NotesCatalogCollectionViewController: UICollectionViewController, UICollectionViewDelegateFlowLayout {
  
  var userArticles = [Articles]()
  let reuseIdentifier = "Cell"
  
  let buttonTest: UIButton = {
    let button = UIButton()
    button.layer.cornerRadius = 10
    button.layer.shadowColor = UIColor.MainGreenColor.cgColor
    button.layer.shadowOpacity = 1
    button.layer.shadowOffset = .init(width: 0, height: 7)
    button.layer.shadowRadius = 7
    button.translatesAutoresizingMaskIntoConstraints = false
    button.backgroundColor = .MainGreenColor
    button.layer.cornerRadius = 30
    button.addTarget(self, action: #selector(createArticle), for: .touchUpInside)
    return button
  }()
  
  override func viewDidLoad() {
    super.viewDidLoad()
    getData()
    settingButton()
    NotificationCenter.default.addObserver(self, selector: #selector(loadList),
                                           name: NSNotification.Name(rawValue: "refreshData"), object: nil)
    self.navigationController?.navigationBar.setBackgroundImage(UIImage(), for: UIBarMetrics.default)
    self.navigationController?.navigationBar.shadowImage = UIImage()
    self.navigationController?.navigationBar.isTranslucent = true
    // Register cell classes
    self.collectionView!.register(NotesCatalogCollectionViewCell.self, forCellWithReuseIdentifier: reuseIdentifier)
  }
  
  func getData() {
    Reference().correctReference().child(FirebaseEntity.articles.rawValue)
      .child(Reference().returnUserID()).observeSingleEvent(of: .value, with: { (snapshot) in
      
      guard let data = snapshot.value as? NSDictionary else {return}
      for value in data.allValues{
        let infoItem = Articles(dict: value as! NSDictionary)
        self.userArticles.append(infoItem)
        self.collectionView.reloadData()
        print(value)
        print(self.userArticles)
      }
      
      // ...
    }) { (error) in
      print(error.localizedDescription)
    }
  }
  
  @objc func loadList(notification: NSNotification){
    userArticles.removeAll()
    getData()
  }
  
  @objc func createArticle() {
    print("Кнопка работает")
    let create = self.storyboard?.instantiateViewController(withIdentifier: "CreateArticleViewController") as! CreateArticleViewController
    self.present(create, animated: true, completion: nil)
  }
  
  func settingButton () {
    view.addSubview(buttonTest)
    buttonTest.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -40).isActive = true
    buttonTest.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -30).isActive = true
    buttonTest.heightAnchor.constraint(equalToConstant: 60).isActive = true
    buttonTest.widthAnchor.constraint(equalToConstant: 60).isActive = true
  }

  
  override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
    performSegue(withIdentifier: "PresentArticle", sender: self)
  }
  
}
