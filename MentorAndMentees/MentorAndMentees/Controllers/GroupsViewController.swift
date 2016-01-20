//
//  GroupsViewController.swift
//  MentorAndMentees
//
//  Created by Rebouh Aymen on 20/01/2016.
//  Copyright © 2016 Mentor And Mentees. All rights reserved.
//

import UIKit

class GroupsViewController: BaseViewController {
  
  // MARK: - Properties -
  
  @IBOutlet weak var searchGroupTextField: UITextField!
  @IBOutlet weak var groupsCollectionView: UICollectionView!
}

// MARK: - UICollectionView Data source -

extension GroupsViewController: UICollectionViewDataSource {
  
  func numberOfSectionsInCollectionView(collectionView: UICollectionView) -> Int {
    return 1
  }
  
  func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
    return 8
  }
  
  private struct CollectionView {
    static let identifier                 = "GroupItem"
    static let itemHeight: CGFloat        = 180.0
    static let marginBetweenItem: CGFloat = 10.0
  }
  
  func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
    let groupCollectionViewCell = collectionView.dequeueReusableCellWithReuseIdentifier(CollectionView.identifier,
      forIndexPath: indexPath) as! GroupItemCollectionViewCell
    return groupCollectionViewCell
  }
}

// MARK: - UICollectionView Layout Delegate -

extension GroupsViewController: UICollectionViewDelegateFlowLayout {
  func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAtIndexPath indexPath: NSIndexPath) -> CGSize {
    return CGSize(width: groupsCollectionView!.bounds.width/2.2, height: CollectionView.itemHeight)
  }
  
  func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAtIndex section: Int) -> UIEdgeInsets {
    return UIEdgeInsets(top: CollectionView.marginBetweenItem, left: CollectionView.marginBetweenItem, bottom: CollectionView.marginBetweenItem, right: CollectionView.marginBetweenItem)
  }
}
