//
//  AccessInPhotoArticle.swift
//  notes
//
//  Created by Pavel Anpleenko on 02/11/2019.
//  Copyright © 2019 Pavel Anpleenko. All rights reserved.
//

import Foundation
import UIKit

extension CreateArticleViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
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
      articleImageCover.image = image
    }
  }
  //<-end
}
