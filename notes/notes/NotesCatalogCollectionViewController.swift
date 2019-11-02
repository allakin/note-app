//
//  NotesCatalogCollectionViewController.swift
//  notes
//
//  Created by Pavel Anpleenko on 10/10/2019.
//  Copyright © 2019 Pavel Anpleenko. All rights reserved.
//

import UIKit

private let reuseIdentifier = "Cell"

class NotesCatalogCollectionViewController: UICollectionViewController, UICollectionViewDelegateFlowLayout {

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
    settingButton()
    self.navigationController?.navigationBar.setBackgroundImage(UIImage(), for: UIBarMetrics.default)
    self.navigationController?.navigationBar.shadowImage = UIImage()
    self.navigationController?.navigationBar.isTranslucent = true
    // Register cell classes
    self.collectionView!.register(NotesCatalogCollectionViewCell.self, forCellWithReuseIdentifier: reuseIdentifier)
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
  
  /*
   // MARK: - Navigation
   
   // In a storyboard-based application, you will often want to do a little preparation before navigation
   override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
   // Get the new view controller using [segue destinationViewController].
   // Pass the selected object to the new view controller.
   }
   */
  
  // MARK: UICollectionViewDataSource
  
  override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
    // #warning Incomplete implementation, return the number of items
    return 10
  }
  
  override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
    let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath)
    cell.layer.cornerRadius = 10
    cell.layer.shadowColor = UIColor(red:0.91, green:0.91, blue:0.91, alpha:1.00).cgColor
    cell.layer.shadowOpacity = 1
    cell.layer.shadowOffset = .init(width: 2, height: 7)
    cell.layer.shadowRadius = 7
    return cell
  }
  
  func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
    return CGSize(width: view.frame.width - 60, height: 170)
  }
  
  func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
    return 30
  }
  
  override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
    performSegue(withIdentifier: "PresentArticle", sender: self)
  }
  
  // MARK: UICollectionViewDelegate
  
  /*
   // Uncomment this method to specify if the specified item should be highlighted during tracking
   override func collectionView(_ collectionView: UICollectionView, shouldHighlightItemAt indexPath: IndexPath) -> Bool {
   return true
   }
   */
  
  /*
   // Uncomment this method to specify if the specified item should be selected
   override func collectionView(_ collectionView: UICollectionView, shouldSelectItemAt indexPath: IndexPath) -> Bool {
   return true
   }
   */
  
  /*
   // Uncomment these methods to specify if an action menu should be displayed for the specified item, and react to actions performed on the item
   override func collectionView(_ collectionView: UICollectionView, shouldShowMenuForItemAt indexPath: IndexPath) -> Bool {
   return false
   }
   
   override func collectionView(_ collectionView: UICollectionView, canPerformAction action: Selector, forItemAt indexPath: IndexPath, withSender sender: Any?) -> Bool {
   return false
   }
   
   override func collectionView(_ collectionView: UICollectionView, performAction action: Selector, forItemAt indexPath: IndexPath, withSender sender: Any?) {
   
   }
   */
  
}
