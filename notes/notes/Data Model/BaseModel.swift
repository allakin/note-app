//
//  ArticleModel.swift
//  notes
//
//  Created by Pavel Anpleenko on 04/12/2019.
//  Copyright © 2019 Pavel Anpleenko. All rights reserved.
//

import Foundation

struct Articles {
  var title: String?
  var description: String?
  var coverImage: String?
  var keyID: String?
  
  init(dict: NSDictionary) {
    title = dict.value(forKeyPath: "labelArticle") as? String
    description = dict.value(forKeyPath: "descriptionArticle") as? String
    coverImage = dict.value(forKeyPath: "articleCoverImage") as? String
    keyID = dict.value(forKeyPath: "keyID") as? String
  }
}

struct ChangeUserSetting {
  var userEmail: String?
	var userName: String?
	var userSecondName: String?
	init(email: String, name: String, secondName: String) {
    self.userEmail = email
		self.userName = name
		self.userSecondName = secondName
  }
}
