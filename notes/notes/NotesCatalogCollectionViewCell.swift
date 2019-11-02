//
//  NotesCatalogCollectionViewCell.swift
//  notes
//
//  Created by Pavel Anpleenko on 10/10/2019.
//  Copyright © 2019 Pavel Anpleenko. All rights reserved.
//

import UIKit

class NotesCatalogCollectionViewCell: UICollectionViewCell {
  
  let currentDevice = UIDevice.current.name
  
  override init(frame: CGRect) {
    super.init(frame: frame)
    setupView()
  }
  
  let textLabel: UILabel = {
    let text = UILabel()
    text.translatesAutoresizingMaskIntoConstraints = false
    text.textColor = .TextGrayColor
    text.numberOfLines = 5
    text.lineBreakMode = .byWordWrapping
    text.text = "A Product Manager Musings Calls"
    text.font = UIFont.boldSystemFont(ofSize: 18)
    text.textAlignment = .left
    return text
  }()
  
  let dateLabel: UILabel = {
    let text = UILabel()
    text.translatesAutoresizingMaskIntoConstraints = false
    text.textColor = .TextGrayColor
    text.numberOfLines = 1
    text.lineBreakMode = .byWordWrapping
    text.text = "12/12"
    text.font = UIFont.boldSystemFont(ofSize: 12)
    text.textAlignment = .left
    return text
  }()
  
  let tadLabel: UILabel = {
    let text = UILabel()
    text.translatesAutoresizingMaskIntoConstraints = false
    text.textColor = .LightGrayColor
    text.numberOfLines = 1
    text.lineBreakMode = .byWordWrapping
    text.text = "CEO Cteate"
    text.font = UIFont.boldSystemFont(ofSize: 12)
    text.textAlignment = .left
    return text
  }()
  
  let noteImage: UIImageView = {
    let image = UIImageView()
    image.translatesAutoresizingMaskIntoConstraints = false
    image.backgroundColor = .red
    image.image = UIImage(named: "rose-blue.jpg")
//    image.contentMode = .scaleAspectFit
    return image
  }()
  
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  func setupView() {
    backgroundColor = .white
    addSubview(noteImage)
    addSubview(textLabel)
    addSubview(dateLabel)
    addSubview(tadLabel)
    noteImage.topAnchor.constraint(equalTo: topAnchor, constant: 10).isActive = true
    noteImage.leftAnchor.constraint(equalTo: leftAnchor, constant: 10).isActive = true
    noteImage.widthAnchor.constraint(equalToConstant: 130).isActive = true
    noteImage.heightAnchor.constraint(equalToConstant: 150).isActive = true
    textLabel.topAnchor.constraint(equalTo: topAnchor, constant: 25).isActive = true
    textLabel.leftAnchor.constraint(equalTo: noteImage.rightAnchor, constant: 15).isActive = true
    switch currentDevice {
    case DeviceName.iPhone11ProMax.rawValue:
      textLabel.widthAnchor.constraint(equalToConstant: 180).isActive = true
    case DeviceName.iPhone11Pro.rawValue:
      textLabel.widthAnchor.constraint(equalToConstant: 180).isActive = true
    case DeviceName.iPhone11.rawValue:
      textLabel.widthAnchor.constraint(equalToConstant: 180).isActive = true
    case DeviceName.iPhone8Plus.rawValue:
      textLabel.widthAnchor.constraint(equalToConstant: 180).isActive = true
    default:
      textLabel.font = UIFont.boldSystemFont(ofSize: 16)
      textLabel.widthAnchor.constraint(equalToConstant: 150).isActive = true
    }
    
    dateLabel.topAnchor.constraint(equalTo: textLabel.bottomAnchor, constant: 20).isActive = true
    dateLabel.leftAnchor.constraint(equalTo: noteImage.rightAnchor, constant: 15).isActive = true
    dateLabel.widthAnchor.constraint(equalToConstant: 30).isActive = true
    dateLabel.heightAnchor.constraint(equalToConstant: 20).isActive = true
    
    tadLabel.topAnchor.constraint(equalTo: textLabel.bottomAnchor, constant: 20).isActive = true
    tadLabel.leftAnchor.constraint(equalTo: dateLabel.rightAnchor, constant: 15).isActive = true
    tadLabel.widthAnchor.constraint(equalToConstant: 90).isActive = true
    tadLabel.heightAnchor.constraint(equalToConstant: 20).isActive = true

    
  }
  
}
