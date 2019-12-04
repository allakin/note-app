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
  
  init(dict: NSDictionary) {
    title = dict.value(forKeyPath: "labelArticle") as? String
    description = dict.value(forKeyPath: "descriptionArticle") as? String
  }
  
}
