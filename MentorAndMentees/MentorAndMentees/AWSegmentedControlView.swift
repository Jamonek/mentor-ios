//
//  AWSegmentedControlView.swift
//  AWSegmentedControlView
//
//  Created by Rebouh Aymen on 17/01/2016.
//  Copyright © 2016 Aymen Rebouh. All rights reserved.
//

import UIKit

class AWSegmentedControlView: UIView {
  
  // MARK: - Properties -

  // Setted on the storyboard
  @IBInspectable var firstButtonTitle: String = "Button1" {
    didSet {
      firstButton.setTitle(firstButtonTitle, forState: .Normal)
    }
  }
  
  // Setted on the storyboard
  @IBInspectable var firstButtonImage: String = "Button1" {
    didSet {
      firstButton.setImage(UIImage(named: firstButtonImage), forState: .Normal)
      firstButton.setImage(UIImage(named: firstButtonImage), forState: .Highlighted)
    }
  }

  // Setted on the storyboard
  @IBInspectable var secondButtonTitle: String = "ButtonImage2" {
    didSet {
      secondButton.setTitle(secondButtonTitle, forState: .Normal)
    }
  }
  
  // Setted on the storyboard
  @IBInspectable var secondButtonImage: String = "ButtonImage1" {
    didSet {
      secondButton.setImage(UIImage(named: secondButtonImage), forState: .Normal)
      secondButton.setImage(UIImage(named: secondButtonImage), forState: .Highlighted)
    }
  }

  var firstButton       = UIButton(type: .Custom)
  var secondButton      = UIButton(type: .Custom)
  var isLeft            = true
  var mainGradientColor = CAGradientLayer()
  var secondaryColor    = UIColor.mentorSkyBlueColor()
  
  // MARK: - Lifecycle -

  // Called when loaded from the storyboard
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

    firstButton.setTitle(firstButtonTitle, forState: .Normal)
    firstButton.setTitleColor(UIColor.whiteColor(), forState: .Normal)
    firstButton.addTarget(self, action: "animate", forControlEvents: .TouchUpInside)
    firstButton.imageEdgeInsets   = SegmentedControlProperties.imageEdgeInsets
    firstButton.titleLabel?.font  = SegmentedControlProperties.font

    secondButton.setTitle(secondButtonTitle, forState: .Normal)
    secondButton.setTitleColor(UIColor.whiteColor(), forState: .Normal)
    secondButton.addTarget(self, action: "animate", forControlEvents: .TouchUpInside)
    secondButton.imageEdgeInsets  = SegmentedControlProperties.imageEdgeInsets
    secondButton.titleLabel?.font = SegmentedControlProperties.font
    
    layer.addSublayer(mainGradientColor)
    
    addSubview(firstButton)
    addSubview(secondButton)
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
  }
}
