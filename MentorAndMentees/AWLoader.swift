//
//  AWLoader.swift
//  TestLoader
//
//  Created by Rebouh Aymen on 21/02/2016.
//  Copyright © 2016 Aymen Rebouh. All rights reserved.
//

import UIKit

private extension UIWindow {
  var width: CGFloat {
    return bounds.width
  }
  
  var height: CGFloat {
    return bounds.height
  }
  
  static var currentWindow: UIWindow {
    return (UIApplication.shared.delegate! as! AppDelegate).window!
  }
}

enum AWLoaderShape {
  case square, circle
}

private struct AWLoaderProperties {
  static let shapeViewSize         = CGSize(width: 50.0, height: 50.0)
  static let shapeViewFrame        = CGRect(origin: .zero, size: shapeViewSize)
  static let squareBackgroundColor = UIColor(red: 241/255, green: 241/255, blue: 241/255, alpha: 1.0)
  static let lineColor             = UIColor(red: 128/255, green: 128/255, blue: 128/255, alpha: 1.0)
  static let lineWidth: CGFloat    = 1.3
  
  static func shapeCornierRadius(_ shape: AWLoaderShape = .square) -> CGFloat {
    switch shape {
    case .square: return shapeViewSize.height / 10
    case .circle: return shapeViewSize.height / 2
    }
  }
}

class AWLoaderView: UIView {
  
  fileprivate static let sharedInstance = AWLoader()
  var shapeView: UIView
  var containerShapeView: UIView
  var circleLayer: CAShapeLayer
  var visualEffectView: UIVisualEffectView
  
  // MARK: - Lifecycle -
  
  override init(frame: CGRect) {
    
    containerShapeView                 = UIView(frame: AWLoaderProperties.shapeViewFrame)
    circleLayer                        = CAShapeLayer()
    shapeView                          = UIView(frame: CGRect(origin: CGPoint(x: UIWindow.currentWindow.width/2-AWLoaderProperties.shapeViewSize.width/2,
      y: UIWindow.currentWindow.height/2-AWLoaderProperties.shapeViewSize.height/2), size: AWLoaderProperties.shapeViewSize))
    shapeView.backgroundColor          = AWLoaderProperties.squareBackgroundColor
    shapeView.layer.cornerRadius       = AWLoaderProperties.shapeCornierRadius()
    containerShapeView.backgroundColor = UIColor.clear
    
    shapeView.addSubview(containerShapeView)
    
    visualEffectView       = UIVisualEffectView(effect: UIBlurEffect(style: .light))
    visualEffectView.frame = UIWindow.currentWindow.bounds
    
    visualEffectView.addSubview(shapeView)
    
    // MARK: - Setup Layer -
    
    let center     = containerShapeView.center
    let startAngle = CGFloat(0.0)
    let endAngle   = CGFloat(M_PI*2)
    let radius     = containerShapeView.bounds.width * 0.21
    
    circleLayer.lineWidth   = AWLoaderProperties.lineWidth
    circleLayer.fillColor   = nil
    circleLayer.strokeColor = AWLoaderProperties.lineColor.cgColor
    circleLayer.strokeStart = 0.0
    circleLayer.strokeEnd   = 0.87
    
    let path         = UIBezierPath(arcCenter: center, radius: radius,
      startAngle: startAngle, endAngle: endAngle, clockwise: true)
    circleLayer.path = path.cgPath
    containerShapeView.layer.addSublayer(circleLayer)
    
    super.init(frame: frame)
    self.addSubview(visualEffectView)
  }
  
  override func layoutSubviews() {
    super.layoutSubviews()
    
    visualEffectView.frame   = UIWindow.currentWindow.bounds
    containerShapeView.frame = AWLoaderProperties.shapeViewFrame
    shapeView.frame          = CGRect(origin: CGPoint(x: UIWindow.currentWindow.width/2-AWLoaderProperties.shapeViewSize.width/2,
      y: UIWindow.currentWindow.height/2-AWLoaderProperties.shapeViewSize.height/2), size: AWLoaderProperties.shapeViewSize)
  }

  required init?(coder aDecoder: NSCoder) {
      fatalError("init(coder:) has not been implemented")
  }
  
  func setShape(_ shape: AWLoaderShape) {
    shapeView.layer.cornerRadius = AWLoaderProperties.shapeCornierRadius(shape)
  }
  
  // MARK: - Animations -
  
  func animate() {
    UIWindow.currentWindow.addSubview(AWLoader.sharedInstance)

    func recursiveAnimate() {
      UIView.animate(withDuration: 0.4, delay: 0.0, options: UIViewAnimationOptions.curveLinear, animations: {
        self.containerShapeView.transform = self.containerShapeView.transform.rotated(by: CGFloat(M_PI_2));
        }, completion: {
          if $0 {
            recursiveAnimate()
          }
      })
    }
    
    recursiveAnimate()
  }
}

struct AWLoader {
  
  // MARK: - AWLoader -
  
  static var sharedInstance = AWLoaderView()
  
  // MARK: - API Facade  -
  
  static func show(blurStyle style: UIBlurEffectStyle = .light, shape: AWLoaderShape = .square) {
    AWLoader.sharedInstance.visualEffectView.effect      = UIBlurEffect(style: style)
    AWLoader.sharedInstance.setShape(shape)
    AWLoader.sharedInstance.animate()
  }
  
  static func hide() {
    AWLoader.sharedInstance.removeFromSuperview()
  }
}
