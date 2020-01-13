//
//  ActivityIndicatory.swift
//  notes
//
//  Created by Pavel Anpleenko on 12.01.2020.
//  Copyright © 2020 Pavel Anpleenko. All rights reserved.
//

import UIKit

extension UIView {
  
  func activityStartAnimating(activityColor: UIColor) {
    let backgroundView = UIView()
    let blurEffect = UIBlurEffect(style: .light)
    let blurEffectView = UIVisualEffectView(effect: blurEffect)
    blurEffectView.alpha = 0.6
    blurEffectView.frame = bounds
    blurEffectView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
    addSubview(blurEffectView)
    
    backgroundView.tag = 475647
    
    var activityIndicator: UIActivityIndicatorView = UIActivityIndicatorView()
    activityIndicator = UIActivityIndicatorView(frame: CGRect.init(x: 0, y: 0, width: 50, height: 50))
    activityIndicator.center = self.center
    activityIndicator.hidesWhenStopped = true
    activityIndicator.style = UIActivityIndicatorView.Style.large
    activityIndicator.color = activityColor
    activityIndicator.startAnimating()
    self.isUserInteractionEnabled = false
    
    backgroundView.addSubview(activityIndicator)
    
    self.addSubview(backgroundView)
  }
  
  func activityStopAnimating() {
    if let background = viewWithTag(475647){
      background.removeFromSuperview()
    }
    self.isUserInteractionEnabled = true
  }
}
