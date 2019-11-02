//
//  UIViewCViewController.swift
//  notes
//
//  Created by Pavel Anpleenko on 23/10/2019.
//  Copyright © 2019 Pavel Anpleenko. All rights reserved.
//

import UIKit

class CreateArticleViewController: UIViewController {
  @IBOutlet weak var labelArticle: UITextView!
  @IBOutlet weak var descriptionArticle: UITextView!
  @IBOutlet weak var scrollView: UIScrollView!
  @IBOutlet weak var buttonForEditingCover: UIButton!
  @IBOutlet weak var articleImageCover: UIImageView!
  
  @IBOutlet weak var textVIew: UITextView!
  override func viewDidLoad() {
    super.viewDidLoad()
    
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

}
