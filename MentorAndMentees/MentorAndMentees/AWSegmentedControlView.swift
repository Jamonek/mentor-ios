//
//  AWSegmentedControlView.swift
//  AWSegmentedControlView
//
//  Created by Rebouh Aymen on 17/01/2016.
//  Copyright © 2016 Aymen Rebouh. All rights reserved.
//

import UIKit

typealias AWSegmentedControlViewTitles = (left: String, right: String)
typealias AWSegmentedControlViewImages = AWSegmentedControlViewTitles

protocol AWSegmentedControlViewDataSource: class {
  func titlesForAWSegmentedControlView(awSegmentedControlView: AWSegmentedControlView) -> AWSegmentedControlViewTitles
  func imagesNamesForAWSegmentedControlView(awSegmentedControlView: AWSegmentedControlView) -> AWSegmentedControlViewImages
}

class AWSegmentedControlView: UIView {
  
  // MARK: - Properties -

  weak var dataSource: AWSegmentedControlViewDataSource?

  var firstButton       = UIButton(type: .Custom)
  var secondButton      = UIButton(type: .Custom)
  var isLeft            = true
  var mainGradientColor = CAGradientLayer()
  var secondaryColor    = UIColor.mentorSkyBlueColor()
  
  // MARK: - Lifecycle -

  required init?(coder aDecoder: NSCoder) {
    super.init(coder: aDecoder)
    configure()
  }

  // MARK: - Init -
  
  private struct SegmentedControlProperties {
    static let imageEdgeInsets = UIEdgeInsets(top: 0.0, left: -20.0, bottom: 0.0, right: 0.0)
    static let font            = UIFont.systemFontOfSize(14)
    static let gradientColor   = (left: UIColor(red: 121/255, green: 206/255, blue: 234/255, alpha: 1.0),
      right: UIColor(red: 54/255, green: 141/255, blue: 218/255, alpha: 1.0))
  }
  
  private func configure() {
    backgroundColor = secondaryColor.colorWithAlphaComponent(0.5)
    
    mainGradientColor.startPoint   = CGPoint.zero
    mainGradientColor.endPoint     = CGPoint(x: 1.0, y: 0.0)
    mainGradientColor.colors       = [SegmentedControlProperties.gradientColor.left.CGColor, SegmentedControlProperties.gradientColor.right.CGColor]
    
    layer.addSublayer(mainGradientColor)
    
    addSubview(firstButton)
    addSubview(secondButton)
  }
  
  private func configureTitlesAndImages() {
    firstButton.setTitle(dataSource?.titlesForAWSegmentedControlView(self).left, forState: .Normal)
    firstButton.setTitleColor(UIColor.whiteColor(), forState: .Normal)
    firstButton.addTarget(self, action: "animate", forControlEvents: .TouchUpInside)
    firstButton.imageEdgeInsets   = SegmentedControlProperties.imageEdgeInsets
    firstButton.titleLabel?.font  = SegmentedControlProperties.font
    
    secondButton.setTitle(dataSource?.titlesForAWSegmentedControlView(self).right, forState: .Normal)
    secondButton.setTitleColor(UIColor.whiteColor(), forState: .Normal)
    secondButton.addTarget(self, action: "animate", forControlEvents: .TouchUpInside)
    secondButton.imageEdgeInsets  = SegmentedControlProperties.imageEdgeInsets
    secondButton.titleLabel?.font = SegmentedControlProperties.font
    
    if let imageNameLeft  = dataSource?.imagesNamesForAWSegmentedControlView(self).left,
      imageNameRight = dataSource?.imagesNamesForAWSegmentedControlView(self).right {
        firstButton.setImage(UIImage(named: imageNameLeft), forState: .Normal)
        secondButton.setImage(UIImage(named: imageNameRight), forState: .Normal)
    }
  }
  
  private func setup() {
    layer.cornerRadius              = midHeight
    mainGradientColor.cornerRadius  = midHeight
    mainGradientColor.frame         = CGRect(x: 0.0, y: 0, width: midWidth, height: bounds.height)
    firstButton.frame               = CGRect(x: 0.0, y: 0, width: midWidth, height: bounds.height)
    firstButton.layer.cornerRadius  = firstButton.midHeight
    secondButton.frame              = CGRect(x: midWidth, y: 0, width: midWidth, height: bounds.height)
    secondButton.layer.cornerRadius = firstButton.midHeight
  }
  
  // MARK: - UI Appareance -

  func animate() {
    UIView.animateWithDuration(0.5, animations: {
      let endFrame = CGRect(x: self.isLeft ? self.midWidth : 0.0, y: 0.0, width: self.midWidth, height: self.bounds.height)
      self.mainGradientColor.frame = endFrame
   
      }) { if $0 {
          self.isLeft = !self.isLeft
        }
      }
    }
  
  override func layoutSubviews() {
    super.layoutSubviews()
    setup()
    configureTitlesAndImages()
  }
}
