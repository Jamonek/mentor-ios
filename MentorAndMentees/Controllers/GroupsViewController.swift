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
  
  @IBOutlet weak var groupsTitleLabel: UILabel! {
    didSet {
      groupsTitleLabel.text = Localizable("Groups")
    }
  }
  
  var searchBar: UISearchBar = {
    let searchBar = UISearchBar()
    searchBar.tintColor = UIColor.mentorSkyBlueColor()
    searchBar.placeholder = Localizable("Search")
    return searchBar
  }()
  
  @IBOutlet weak var groupsCollectionView: UICollectionView!
  
  // MARK: - Lifecycle -
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    searchBar.delegate = self
    groupsCollectionView.addSubview(searchBar)

    // To remote the defaut space between the collection top and its top
    automaticallyAdjustsScrollViewInsets = false
    
    // To hide the search bar until the user scrolls ( like the Apple Mail app behavior )
    groupsCollectionView.contentOffset = CGPoint(x: 0, y: 44)
  }
  
  override func viewDidLayoutSubviews() {
    super.viewDidLayoutSubviews()
    searchBar.frame = CGRect(x: 0, y: 0, width: groupsCollectionView.bounds.width, height: 44.0)
  }
}

// MARK: - UISearchBar Delegate -

extension GroupsViewController: UISearchBarDelegate {
  func searchBarShouldBeginEditing(_ searchBar: UISearchBar) -> Bool {
    searchBar.setShowsCancelButton(true, animated: true)
    return true
  }
  
  func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
    searchBar.resignFirstResponder()
    searchBar.setShowsCancelButton(false, animated: true)
  }
}


// MARK: - UICollectionView Data source -

extension GroupsViewController: UICollectionViewDataSource {
  
  func numberOfSections(in collectionView: UICollectionView) -> Int {
    return 1
  }
  
  func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
    return 8
  }
  
  fileprivate struct CollectionView {
    static let identifier                 = "GroupItem"
    static let itemHeight: CGFloat        = 180.0
    static let marginBetweenItem: CGFloat = 10.0
  }
  
  func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
    let groupCollectionViewCell = collectionView.dequeueReusableCell(withReuseIdentifier: CollectionView.identifier,
      for: indexPath) as! GroupItemCollectionViewCell
    return groupCollectionViewCell
  }
}

// MARK: - UICollectionView Layout Delegate -

extension GroupsViewController: UICollectionViewDelegateFlowLayout {
  func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
    return CGSize(width: groupsCollectionView!.bounds.width/2.2, height: CollectionView.itemHeight)
  }
  
  func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
    return UIEdgeInsets(top: CollectionView.marginBetweenItem, left: CollectionView.marginBetweenItem, bottom: CollectionView.marginBetweenItem, right: CollectionView.marginBetweenItem)
  }
}
