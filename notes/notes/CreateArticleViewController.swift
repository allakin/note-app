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
  @IBOutlet weak var textVIew: UITextView!
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    saveArticleButtonOutlet.layer.cornerRadius = 30
    saveArticleButtonOutlet.layer.shadowColor = UIColor.LightOrangeColor.cgColor
    saveArticleButtonOutlet.layer.shadowOpacity = 1
    saveArticleButtonOutlet.layer.shadowOffset = .init(width: 0, height: 7)
    saveArticleButtonOutlet.layer.shadowRadius = 7
    
    //add placeholder
    labelArticle.text = "Заголовок"
    labelArticle.textColor = UIColor.lightGray
    descriptionArticle.text = "Описание"
    descriptionArticle.textColor = UIColor.lightGray
    //<-end
    
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
  
  @IBAction func saveArticleButtonAction(_ sender: Any) {
    dismiss(animated: true) {
      self.saveDataInFireBase()
    }
  }
  
  func saveDataInFireBase() {
    guard let title = labelArticle.text,
      let description = descriptionArticle.text else { return }
    
    let data = ["labelArticle": title,
                "descriptionArticle": description]
    Reference().correctReference().child(FirebaseEntity.articles.rawValue)
      .child(Reference().returnUserID()).childByAutoId().setValue(data)
    NotificationCenter.default.post(name: NSNotification.Name(rawValue: "refreshData"), object: nil)
    print("work")
  }
  
}

