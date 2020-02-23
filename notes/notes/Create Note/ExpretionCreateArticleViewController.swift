//
//  ExpretionCreateArticleViewController.swift
//  notes
//
//  Created by Pavel Anpleenko on 02/11/2019.
//  Copyright © 2019 Pavel Anpleenko. All rights reserved.
//

import Foundation
import UIKit

extension CreateArticleViewController: UITextViewDelegate {
  
  //chage height textview
  func textViewDidChange(_ textView: UITextView) {
    print(textView.text)
    let size = CGSize(width: view.frame.width, height: .infinity)
    let estimatedSize = textView.sizeThatFits(size)
    
    textView.constraints.forEach { (constraint) in
      if constraint.firstAttribute == .height {
        constraint.constant = estimatedSize.height
      }
    }
  }
  //<-end
  
  //add placeholders
  func textViewDidBeginEditing(_ textView: UITextView) {
    if textView.textColor == UIColor.lightGray {
      textView.text = nil
      textView.textColor = UIColor.black
    }
  }
  
  func textViewDidEndEditing(_ textView: UITextView) {
    if labelArticle.text.isEmpty {
      textView.text = "Заголовок"
      textView.textColor = UIColor.lightGray
    }
    
    if descriptionArticle.text.isEmpty {
      textView.text = "Описание"
      textView.textColor = UIColor.lightGray
    }
  }
  //<-end
  
  //hide keyboard
  func setupToHideKeyboardOnTapOnView() {
    let tap: UITapGestureRecognizer = UITapGestureRecognizer(
      target: self,
      action: #selector(CreateArticleViewController.dismissKeyboard))
    
    tap.cancelsTouchesInView = false
    view.addGestureRecognizer(tap)
  }
  
  @objc func dismissKeyboard() {
    view.endEditing(true)
  }
  //<-end
}
