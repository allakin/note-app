//
//  NotesCatalogCollectionViewControllerDataSourse.swift
//  notes
//
//  Created by Pavel Anpleenko on 04/12/2019.
//  Copyright © 2019 Pavel Anpleenko. All rights reserved.
//

import UIKit
import Firebase

extension NotesCatalogCollectionViewController {
  
  // MARK: UICollectionViewDataSource
  
  override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
    // #warning Incomplete implementation, return the number of items
    return userArticles.count
  }
  
  override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
    let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath) as! NotesCatalogCollectionViewCell
    cell.layer.cornerRadius = 10
    cell.layer.shadowColor = UIColor(red:0.91, green:0.91, blue:0.91, alpha:1.00).cgColor
    cell.layer.shadowOpacity = 1
    cell.layer.shadowOffset = .init(width: 2, height: 7)
    cell.layer.shadowRadius = 7
    let info = userArticles[indexPath.item]
    
    cell.refresh(info: info)
//    print(userArticles)
    return cell
  }
  
  func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
    return CGSize(width: view.frame.width - 60, height: 170)
  }
  
  func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
    return 30
  }
  
  func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
    return CGSize(width: view.frame.size.width, height: 120)
  }
  
}
