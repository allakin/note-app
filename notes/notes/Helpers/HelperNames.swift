//
//  HelperDeviceName.swift
//  notes
//
//  Created by Pavel Anpleenko on 13/10/2019.
//  Copyright © 2019 Pavel Anpleenko. All rights reserved.
//

import Foundation
import UIKit

enum DeviceName: String{
  case iPhone11ProMax = "iPhone 11 Pro Max"
  case iPhone11Pro = "iPhone 11 Pro"
  case iPhone11 = "iPhone 11"
  case iPhone8Plus = "iPhone 8 Plus"
  case iPhone8 = "iPhone 8"
}

enum FirebaseEntity: String {
  case articles = "articles"
  case articlesCoverFolder = "ArticlesCoverFolder"
  case personInformation = "PersonInformation"
}

enum StoreKey: String {
	case labelArticle = "labelArticle"
	case descriptionArticle = "descriptionArticle"
	case articleCoverImage = "articleCoverImage"
	case keyID = "keyID"
	case personName = "PersonName"
	case personSecondName = "PersonSecondName"
	case userEmail = "UserEmail"
	case saveUserAvatarInUserDefaults = "UserAvatarImage"
}

class StoreKeyList {
  func getKeyFromStore(key: StoreKey) -> String {
    switch key {
    case .labelArticle:
      return "labelArticle"
    case .descriptionArticle:
      return "descriptionArticle"
    case .articleCoverImage:
      return "articleCoverImage"
    case .keyID:
      return "keyID"
    case .personName:
      return "PersonName"
    case .personSecondName:
      return "PersonSecondName"
    case .userEmail:
      return "UserEmail"
		case .saveUserAvatarInUserDefaults:
			return "UserAvatarImage"
    default:
      return ""
    }
  }
}

class StoreKeysFirebaseEntity {
	func getEntityKeyFromFirebase(key: FirebaseEntity) -> String {
		switch key {
		case .articles:
			return "articles"
		case .articlesCoverFolder:
			return "ArticlesCoverFolder"
		case .personInformation:
			return "PersonInformation"
		default:
			return ""
		}
	}
}
