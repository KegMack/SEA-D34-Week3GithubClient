//
//  UserSearchViewController.swift
//  Week3GithubClient
//
//  Created by User on 4/15/15.
//  Copyright (c) 2015 Craig_Chaillie. All rights reserved.
//

import UIKit

class UserSearchViewController: UIViewController, UICollectionViewDataSource, UISearchBarDelegate, UINavigationControllerDelegate {

  @IBOutlet weak var collectionView: UICollectionView!
  @IBOutlet weak var searchBar: UISearchBar!
  
  let imageDisplayAnimationDuration = 0.4
  let imageService = ImageFetchService()
  var users = [User]()
  
  override func viewWillAppear(animated: Bool) {
    super.viewWillAppear(animated)
    self.navigationController?.delegate = self
  }

  override func viewWillDisappear(animated: Bool) {
    super.viewWillDisappear(animated)
    self.navigationController?.delegate = nil
  }

  //MARK: searchBar Delegation
  
  func searchBarSearchButtonClicked(searchBar: UISearchBar) {
    searchBar.resignFirstResponder()
    GithubService.defaultService.fetchUsers(searchBar.text, completionHandler: { (data, error) -> (Void) in
      if error != nil {
        println(error)
      }
      else {
        self.users = data!
        self.collectionView.reloadData()
      }
    })
  }
  
  
  //MARK: collectionView Delegation
  
  func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
    return users.count 
  }
  
  func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
    let cell = collectionView.dequeueReusableCellWithReuseIdentifier("UserCell", forIndexPath: indexPath) as! UserCollectionViewCell
    cell.tag++
    let tag = cell.tag
    cell.imageView.image = nil
    if let image = self.users[indexPath.row].avatarImage {
      cell.imageView.image = image
    } else {
      self.imageService.fetchImageFromURL(self.users[indexPath.row].avatarURL, completionHandler: { (userImage) -> (Void) in
        if let image = userImage where tag == cell.tag {
          self.users[indexPath.row].avatarImage = image
          cell.imageView.transform = CGAffineTransformMakeScale(0.2, 0.2)
          cell.imageView.image = image
          UIView.animateWithDuration(self.imageDisplayAnimationDuration, animations: { () -> Void in
            cell.imageView.transform = CGAffineTransformMakeScale(1.0, 1.0)
          })
        }
      })
    }
    return cell
  }
  
  //MARK: Segue Transition
  
  override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
    if segue.identifier == "UserDetailSegue" {
      let destinationVC = segue.destinationViewController as! UserDetailViewController
      let selectedIndexPath = self.collectionView.indexPathsForSelectedItems().first as! NSIndexPath
      destinationVC.user = self.users[selectedIndexPath.row]
      println("segue")
    }
  }
  
  func navigationController(navigationController: UINavigationController, animationControllerForOperation operation: UINavigationControllerOperation, fromViewController fromVC: UIViewController, toViewController toVC: UIViewController) -> UIViewControllerAnimatedTransitioning? {
    if toVC is UserDetailViewController {
      println("new animation")
      return ToUserDetailAnimationObject()
    } else {
      return nil
    }
  }
  
}
