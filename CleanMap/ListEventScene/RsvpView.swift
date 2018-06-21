//
//  RsvpProfileImageView.swift
//  CleanMap
//
//  Created by Paul Lee on 2018/6/11.
//  Copyright © 2018年 Paul Lee. All rights reserved.
//

import UIKit
import Kingfisher

@IBDesignable
class RsvpView: UIView {
  //MARK: - initialization
  override init(frame: CGRect) {
    super.init(frame: frame)
    setupAvatar()
  }
  
  required init?(coder aDecoder: NSCoder) {
    super.init(coder: aDecoder)
    setupAvatar()
  }
  
  //MARK: - appearance properties
  var avatorSize: CGSize = CGSize(width: 35, height: 35) {
    didSet {
      setupAvatar()
    }
  }
  
  var leading: CGFloat = 8 {
    didSet {
      setupAvatar()
    }
  }
  
  var overlapping: CGFloat = 8 {
    didSet {
      setupAvatar()
    }
  }
  
  var borderWidth: CGFloat = 1 {
    didSet {
      setupAvatar()
    }
  }

  var maxNumberOfAvator: Int {
    let M = floor(frame.size.width + overlapping)/(avatorSize.width + overlapping)
    return Int(M) - 1 //1 for rspv label
  }
  
  
  /// _ & @IBInspectable make this variable accessable through stroy board
  @IBInspectable private var _preferedNumberOfAvator: Int = 5 {
    didSet {
      if _preferedNumberOfAvator <= maxNumberOfAvator {
        setupAvatar()
      }
    }
  }
  
  
  //MARK: - logic properties
  
  /// Do not access it's value directly, using it's setter and getter instead
  private var _avatorUrls: [String] = [] {
    didSet {
      setupAvatar()
    }
  }
  var numberOfAvator: Int {
    return _avatorUrls.count
  }
  
  var avatorUrls: [String] {
    set {
      if newValue.count <= _preferedNumberOfAvator {
        _avatorUrls = newValue
      
      } else {
        let urls = Array(newValue[0..<_preferedNumberOfAvator])
        _avatorUrls = urls
      
      }
    }
    
    get {
      return _avatorUrls
    }
  }
  
  private var imageViews: [UIImageView]  = []
  var rsvpLabel: UILabel = {
    let label = UILabel()
    label.textColor = UIColor.darkGray
    label.font = UIFont.systemFont(ofSize: 12)
    return label
  }()
  
  func loadImagesFromUrls() {
    guard imageViews.count == avatorUrls.count else {
      fatalError("number of avator Image views:\(imageViews.count) should equals to number avator image urls:\(avatorUrls.count)")
    }
    
    for (idx, imageView) in imageViews.enumerated() {
      let url = URL(string: avatorUrls[idx])
      imageView.kf.setImage(with: url)
    }
  }
  
  private func setupAvatar() {
    //remove old avatars
    for view in subviews {
      view.removeFromSuperview()
    }
    imageViews.removeAll()
    
    //draw avatars
    let cell = superview?.superview as? EventTableViewCell
    cell?.rsvpViewHeightLayout.constant = 50
    cell?.rsvpViewTopVerticalLayout.constant = 8
    cell?.layoutIfNeeded()
    
    guard  numberOfAvator > 0 else {
      //let cell = superview?.superview as? EventTableViewCell
      cell?.rsvpViewHeightLayout.constant = 0
      cell?.rsvpViewTopVerticalLayout.constant = 0
      cell?.layoutIfNeeded()
      return
    }
    
    for i in 1...numberOfAvator {
      let image: UIImage? = R.image.defaultUser()
      let imageView = UIImageView(image: image)
      
      //position
      let x = leading + CGFloat(i-1)*(avatorSize.width - overlapping)
      let y = frame.size.height/2 - avatorSize.height/2
      let origin = CGPoint(x: x, y: y)
      imageView.frame = CGRect(origin: origin, size: avatorSize)
      
      //appearance
      imageView.layer.cornerRadius = avatorSize.width/2
      imageView.clipsToBounds = true
      imageView.layer.borderColor = UIColor.white.cgColor
      imageView.layer.borderWidth = borderWidth
      
      addSubview(imageView)
      sendSubview(toBack: imageView)
      imageViews.append(imageView)
      
    }
    
    //draw rsvpLabel
    let size = CGSize(width: 50, height: 20)
    let x = leading + CGFloat(numberOfAvator)*(avatorSize.width - overlapping) + leading*1.5
    let y = frame.size.height/2 - size.height/2
    let origin = CGPoint(x: x, y: y)
    rsvpLabel.frame = CGRect(origin: origin, size: size)
    if rsvpLabel.superview == nil {
      addSubview(rsvpLabel)
    }
    rsvpLabel.text = "\(numberOfAvator)"
    
  }

}


