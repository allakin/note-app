//
//  UIViewCViewController.swift
//  notes
//
//  Created by Pavel Anpleenko on 23/10/2019.
//  Copyright © 2019 Pavel Anpleenko. All rights reserved.
//

import UIKit
import Firebase

class CreateArticleViewController: UIViewController {
  
  @IBOutlet weak var labelArticle: UITextView!
  @IBOutlet weak var descriptionArticle: UITextView!
  @IBOutlet weak var scrollView: UIScrollView!
  @IBOutlet weak var buttonForEditingCover: UIButton!
  @IBOutlet weak var articleImageCover: UIImageView!
  @IBOutlet weak var saveArticleButtonOutlet: UIButton!
  @IBOutlet weak var deleteArticleButtonOutlet: UIButton!
  
  var titleOFArticle: String = ""
  var imageOFArticle: String = ""
  var descriptionOFArticle: String = ""
  var keyID: String = ""
  var articleIsChanced = false
  
  override func viewDidLoad() {
    super.viewDidLoad()
    view.overrideUserInterfaceStyle = .light
    
    saveArticleButtonOutlet.layer.cornerRadius = 30
    saveArticleButtonOutlet.layer.shadowColor = UIColor.LightOrangeColor.cgColor
    saveArticleButtonOutlet.layer.shadowOpacity = 1
    saveArticleButtonOutlet.layer.shadowOffset = .init(width: 0, height: 7)
    saveArticleButtonOutlet.layer.shadowRadius = 7
    
    deleteArticleButtonOutlet.layer.cornerRadius = 30
    deleteArticleButtonOutlet.layer.shadowColor = UIColor.lightGray.cgColor
    deleteArticleButtonOutlet.layer.shadowOpacity = 1
    deleteArticleButtonOutlet.layer.shadowOffset = .init(width: 0, height: 7)
    deleteArticleButtonOutlet.layer.shadowRadius = 7
    
    DataProvider.shared.downloadImageInCache(url: imageOFArticle) { (image) in
      self.articleImageCover.image = image
    }
    
    //add placeholder
    if titleOFArticle == "" {
      articleIsChanced = false
      labelArticle.text = "Заголовок"
      labelArticle.textColor = UIColor.lightGray
      deleteArticleButtonOutlet.isHidden = true
      deleteArticleButtonOutlet.isEnabled = false
    } else {
      articleIsChanced = true
      labelArticle.text = titleOFArticle
      labelArticle.textColor = UIColor.black
    }
    
    if descriptionOFArticle == "" {
      articleIsChanced = false
      descriptionArticle.text = "Описание"
      descriptionArticle.textColor = UIColor.lightGray
      deleteArticleButtonOutlet.isHidden = true
      deleteArticleButtonOutlet.isEnabled = false
    } else {
      articleIsChanced = true
      descriptionArticle.text = titleOFArticle
      descriptionArticle.textColor = UIColor.black
    }
    //<-end
    
    if keyID != "" {
      deleteArticleButtonOutlet.isHidden = false
      deleteArticleButtonOutlet.isEnabled = true
    }
    
    //add chage textview
    //    labelNameTest.font = UIFont.preferredFont(forTextStyle: .title1)
    labelArticle.font = UIFont.boldSystemFont(ofSize: 30)
    
    labelArticle.delegate = self
    
    descriptionArticle.font = UIFont.preferredFont(forTextStyle: .body)
    descriptionArticle.textColor = .lightGray
    descriptionArticle.delegate = self
    
    textViewDidChange(labelArticle)
    textViewDidChange(descriptionArticle)
    //<-end
    
    setupToHideKeyboardOnTapOnView()
  }
  
  @IBAction func buttonPressed(_ sender: Any) {
    print("work")
    descriptionArticle.becomeFirstResponder()
  }
  
  @IBAction func buttonForEditingCoverPressed(_ sender: Any) {
    print("work")
    showAlert()
  }
  
  @IBAction func deleteArticleButtonAction(_ sender: Any) {
    Reference().correctReference()
      .child(FirebaseEntity.articles.rawValue)
      .child(Reference().returnUserID()).child(keyID).removeValue { (error, _) in
        if let error = error {
          print(error.localizedDescription)
        }
        self.dismiss(animated: true) {
          NotificationCenter.default.post(name: NSNotification.Name(rawValue: "refreshData"), object: nil)
        }
    }
  }
  
  
  @IBAction func saveArticleButtonAction(_ sender: Any) {
    dismiss(animated: true) {
      switch self.articleIsChanced {
      case false:
        if self.labelArticle.text == "Заголовок" && self.descriptionArticle.text == "Описание" {
          self.dismiss(animated: true, completion: nil)
        } else {
          self.saveDataInFireBase()
        }
      case true:
        self.updateDataBase()
      default:
        break
      }
    }
  }
  
  func updateDataBase() {
    guard let title = labelArticle.text,
      let description = descriptionArticle.text,
      let image = articleImageCover.image else { return }
    
    let storageReference = Storage.storage().reference()
      .child(FirebaseEntity.articlesCoverFolder.rawValue).child("\(image)")
    
    if let profileImage = self.articleImageCover.image,
      let uploadData = profileImage.jpegData(compressionQuality: 0.1) {
      
      storageReference.putData(uploadData, metadata: nil, completion: { (_, error) in
        
        if let error = error {
          print(error)
          return
        }
        
        storageReference.downloadURL(completion: { (url, err) in
          if let err = err {
            print(err)
            return
          }
          
          guard let url = url else { return }
          guard let key = Reference().correctReference()
            .child(FirebaseEntity.articles.rawValue)
            .child(Reference().returnUserID())
            .child(self.keyID).key else { return }
          let post = [StoreKey.labelArticle.rawValue: title,
                      StoreKey.descriptionArticle.rawValue: description,
                      StoreKey.keyID.rawValue: self.keyID,
                      StoreKey.articleCoverImage.rawValue: url.absoluteString]
          let childUpdates = ["/\(FirebaseEntity.articles.rawValue)/\(Reference().returnUserID())/\(key)/": post]
          Reference().correctReference().updateChildValues(childUpdates)
          NotificationCenter.default.post(name: NSNotification.Name(rawValue: "refreshData"), object: nil)
          print("Data Changed")
        })
      })
    }
  }
  
  
  
  func saveDataInFireBase() {
    guard let title = labelArticle.text,
      let description = descriptionArticle.text, let image = articleImageCover.image else { return }

    let storageReference = Storage.storage().reference()
    .child(FirebaseEntity.articlesCoverFolder.rawValue).child("\(image)")
    
    if let profileImage = self.articleImageCover.image,
      let uploadData = profileImage.jpegData(compressionQuality: 0.1) {
      
      storageReference.putData(uploadData, metadata: nil, completion: { (_, error) in
        
        if let error = error {
          print(error)
          return
        }
        
        storageReference.downloadURL(completion: { (url, err) in
          if let err = err {
            print(err)
            return
          }
          
          guard let url = url else { return }
          let keyID = Reference().correctReference().childByAutoId().key
          let data = [StoreKey.labelArticle.rawValue: title,
                      StoreKey.descriptionArticle.rawValue: description,
                      StoreKey.articleCoverImage.rawValue: url.absoluteString,
                      StoreKey.keyID.rawValue: keyID]
          Reference().correctReference().child(FirebaseEntity.articles.rawValue)
            .child(Reference().returnUserID()).child(keyID ?? "").setValue(data)
          NotificationCenter.default.post(name: NSNotification.Name(rawValue: "refreshData"), object: nil)
          print("Data Saved!")
        })
      })
    }
  }
  
}

