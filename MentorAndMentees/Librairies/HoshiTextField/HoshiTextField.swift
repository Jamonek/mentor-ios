//
//  HoshiTextField.swift
//  TextFieldEffects
//
//  Created by Raúl Riera on 24/01/2015.
//  Copyright (c) 2015 Raul Riera. All rights reserved.
//

import UIKit

/**
 An HoshiTextField is a subclass of the TextFieldEffects object, is a control that displays an UITextField with a customizable visual effect around the lower edge of the control.
 */
open class HoshiTextField: TextFieldEffects {
  
  /**
   The color of the border when it has no content.
   
   This property applies a color to the lower edge of the control. The default value for this property is a clear color.
   */
  @IBInspectable dynamic open var borderInactiveColor: UIColor? {
    didSet {
      updateBorder()
    }
  }
  
  /**
   The color of the border when it has content.
   
   This property applies a color to the lower edge of the control. The default value for this property is a clear color.
   */
  @IBInspectable dynamic open var borderActiveColor: UIColor? {
    didSet {
      updateBorder()
    }
  }
  
  /**
   The color of the placeholder text.
   
   This property applies a color to the complete placeholder string. The default value for this property is a black color.
   */
  @IBInspectable dynamic open var placeholderColor: UIColor = .black {
    didSet {
      updatePlaceholder()
    }
  }
  
  override open var placeholder: String? {
    didSet {
      updatePlaceholder()
    }
  }
  
  override open var bounds: CGRect {
    didSet {
      updateBorder()
      updatePlaceholder()
    }
  }
  
  fileprivate let borderThickness: (active: CGFloat, inactive: CGFloat) = (active: 1.6, inactive: 0.5)
  fileprivate let placeholderInsets = CGPoint(x: 0, y: 6)
  fileprivate let textFieldInsets = CGPoint(x: 0, y: 12)
  fileprivate let inactiveBorderLayer = CALayer()
  fileprivate let activeBorderLayer = CALayer()
  fileprivate var activePlaceholderPoint: CGPoint = CGPoint.zero
  
  // MARK: - TextFieldsEffects
  
  override open func drawViewsForRect(_ rect: CGRect) {
    let frame = CGRect(origin: CGPoint.zero, size: CGSize(width: rect.size.width, height: rect.size.height))
    
    placeholderLabel.frame = frame.insetBy(dx: placeholderInsets.x, dy: placeholderInsets.y)
    placeholderLabel.font = placeholderFontFromFont(font!)
    
    updateBorder()
    updatePlaceholder()
    
    layer.addSublayer(inactiveBorderLayer)
    layer.addSublayer(activeBorderLayer)
    addSubview(placeholderLabel)
    
    activePlaceholderPoint = CGPoint(x: placeholderLabel.frame.origin.x, y: placeholderLabel.frame.origin.y - placeholderLabel.frame.size.height - placeholderInsets.y)
  }
  
  override open func animateViewsForTextEntry() {
    if text!.isEmpty {
      UIView.animate(withDuration: 0.3, delay: 0.0, usingSpringWithDamping: 0.8, initialSpringVelocity: 1.0, options: .beginFromCurrentState, animations: ({
        self.placeholderLabel.frame.origin = CGPoint(x: 10, y: self.placeholderLabel.frame.origin.y)
        self.placeholderLabel.alpha = 0
      }), completion:nil)
    }
    
    layoutPlaceholderInTextRect()
    placeholderLabel.frame.origin = activePlaceholderPoint
    
    UIView.animate(withDuration: 0.2, animations: {
      self.placeholderLabel.alpha = 0.5
    })
    
    activeBorderLayer.frame = self.rectForBorder(self.borderThickness.active, isFilled: true)
  }
  
  override open func animateViewsForTextDisplay() {
    if text!.isEmpty {
      UIView.animate(withDuration: 0.35, delay: 0.0, usingSpringWithDamping: 0.8, initialSpringVelocity: 2.0, options: UIViewAnimationOptions.beginFromCurrentState, animations: ({ [unowned self] in
        self.layoutPlaceholderInTextRect()
        self.placeholderLabel.alpha = 1
        }), completion: nil)
    }
    self.activeBorderLayer.frame = self.rectForBorder(self.borderThickness.active, isFilled: false)
    
  }
  
  // MARK: - Private
  
  func updateBorder() {
    inactiveBorderLayer.frame = rectForBorder(borderThickness.inactive, isFilled: true)
    inactiveBorderLayer.backgroundColor = borderInactiveColor?.cgColor
    
    activeBorderLayer.frame = rectForBorder(borderThickness.active, isFilled: false)
    activeBorderLayer.backgroundColor = borderActiveColor?.cgColor
  }
  
  func updatePlaceholder() {
    placeholderLabel.text = placeholder
    placeholderLabel.textColor = placeholderColor
    placeholderLabel.sizeToFit()
    layoutPlaceholderInTextRect()
    
    if isFirstResponder() || text!.isNotEmpty {
      animateViewsForTextEntry()
    }
  }
  
  fileprivate func placeholderFontFromFont(_ font: UIFont) -> UIFont! {
    let smallerFont = UIFont(name: font.fontName, size: font.pointSize * 0.65)
    return smallerFont
  }
  
  fileprivate func rectForBorder(_ thickness: CGFloat, isFilled: Bool) -> CGRect {
    if isFilled {
      return CGRect(origin: CGPoint(x: 0, y: (frame).height-thickness), size: CGSize(width: (frame).width, height: thickness))
    } else {
      return CGRect(origin: CGPoint(x: 0, y: (frame).height-thickness), size: CGSize(width: 0, height: thickness))
    }
  }
  
  func layoutPlaceholderInTextRect() {
    let textRect = textRectForBounds(bounds)
    var originX = textRect.origin.x
    switch self.textAlignment {
    case .Center:
      originX += textRect.size.width/2 - placeholderLabel.bounds.width/2
    case .Right:
      originX += textRect.size.width - placeholderLabel.bounds.width
    default:
      break
    }
    placeholderLabel.frame = CGRect(x: originX, y: textRect.height/2,
      width: placeholderLabel.bounds.width, height: placeholderLabel.bounds.height)
  }
  
  // MARK: - Overrides
  
  override open func editingRectForBounds(_ bounds: CGRect) -> CGRect {
    return bounds.offsetBy(dx: textFieldInsets.x, dy: textFieldInsets.y)
  }
  
  override open func textRectForBounds(_ bounds: CGRect) -> CGRect {
    return bounds.offsetBy(dx: textFieldInsets.x, dy: textFieldInsets.y)
  }
  
}
