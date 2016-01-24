//
//  GroupItemCollectionViewCell.swift
//  MentorAndMentees
//
//  Created by Rebouh Aymen on 20/01/2016.
//  Copyright © 2016 Mentor And Mentees. All rights reserved.
//

import UIKit

class GroupItemCollectionViewCell: UICollectionViewCell {
  
  // MARK: - Properties -

  @IBOutlet weak var iconImageView: UIImageView!
  @IBOutlet weak var nameLabel: UILabel!
  @IBOutlet weak var membersLabel: UILabel!
  @IBOutlet weak var lastActivityLabel: UILabel!
  @IBOutlet weak var moreButton: UIButton!
  
  private struct MenuControllerOptions {
    static let deleteGroup: Selector      = "deleteGroup";
    static let renameGroup: Selector      = "renameGroup";
    static let moreInformations: Selector = "moreInformations";
  }
  
  lazy var optionsMenuController: UIMenuController = {
    let menu = UIMenuController.sharedMenuController()
    menu.menuItems = [UIMenuItem(title: Localizable("Delete"), action: MenuControllerOptions.deleteGroup),
                      UIMenuItem(title: Localizable("Rename"), action: MenuControllerOptions.renameGroup),
                      UIMenuItem(title: Localizable("More"), action: MenuControllerOptions.moreInformations)]
  
    return menu
  }()
  
  // MARK: - Lifecycle -
  
  required init?(coder aDecoder: NSCoder) {
    super.init(coder: aDecoder)
    
    layer.cornerRadius = 4.0
  }

  // MARK: - User Interaction -
  
  override func canPerformAction(action: Selector, withSender sender: AnyObject?) -> Bool {
    return action == MenuControllerOptions.deleteGroup || action == MenuControllerOptions.renameGroup || action == MenuControllerOptions.moreInformations
  }
  
  override func canBecomeFirstResponder() -> Bool {
    return true
  }
  
  @IBAction func showMenu(sender: AnyObject) {
    becomeFirstResponder()
    
    optionsMenuController.setTargetRect(moreButton.frame, inView: self)
    optionsMenuController.setMenuVisible(true, animated: true)
  }
  
  func deleteGroup() {
    // TODO: -
  }
  
  func renameGroup() {
    // TODO: -
  }
  
  func moreInformations() {
    // TODO: -
  }
}
