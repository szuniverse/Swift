//
//  BorderButton.swift
//  AirAber
//
//  Created by David Szurma on 11/8/16.
//  Copyright © 2016 Mic Pringle. All rights reserved.
//

import UIKit

@IBDesignable
class RatingView: UIView {
  
  override init(frame: CGRect) {
    super.init(frame: frame)
    
    setUpView()
  }
  
  required init(coder aDecoder: NSCoder) {
    super.init(coder: aDecoder)!
  
  }
  
  func setUpView() {
    
    let imageView = UIImageView(frame:CGRect(x: 0, y: 0, width: 50, height: 50))
    imageView.image = UIImage(named: "Progress2")
    imageView.backgroundColor = UIColor.red
    addSubview(imageView)
  }
}
