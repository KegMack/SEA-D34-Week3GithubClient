//
//  UserDetailViewController.swift
//  Week3GithubClient
//
//  Created by User on 4/15/15.
//  Copyright (c) 2015 Craig_Chaillie. All rights reserved.
//

import UIKit

class UserDetailViewController: UIViewController {

  
  @IBOutlet weak var userImageView: UIImageView!
  @IBOutlet weak var nameLabel: UILabel!
  @IBOutlet weak var locationLabel: UILabel!
  @IBOutlet weak var bioLabel: UILabel!
  @IBOutlet weak var hireableLabel: UILabel!
  
  var user: User?
  let imageService = ImageFetchService()
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    if self.user == nil {
      // Use authenticated user if none assigned
      GithubService.defaultService.fetchMyProfile({ [weak self] (user, error) -> (Void) in
        if user != nil && self != nil {
          self!.user = user!
          self!.updateUI()
        }
      })
    }
    else  {
      GithubService.defaultService.fetchUserInfo(self.user!, completionHandler: { [weak self] (detailedUser, error) -> (Void) in
        if error != nil {
          println(error)
        }
        else {
          if self != nil {
            self!.user = detailedUser
            NSOperationQueue.mainQueue().addOperationWithBlock({ () -> Void in
              self!.updateUI()
            })
          }
        }
      })
    }
  }
  
  func updateUI() {
    self.nameLabel.text = self.user?.name
    self.locationLabel.text = self.user?.location
    self.bioLabel.text = self.user?.bio
    self.hireableLabel.text = self.hireableToText(self.user?.hireable)
    if let image = self.user?.avatarImage {
      self.userImageView.image = image
    } else {
      self.imageService.fetchImageFromURL(self.user!.avatarURL, completionHandler: { [weak self] (userImage) -> (Void) in
        if self != nil {
          if let image = userImage {
            self!.user!.avatarImage = image
            self!.userImageView.transform = CGAffineTransformMakeScale(0.2, 0.2)
            self!.userImageView.image = image
            UIView.animateWithDuration(1.0, animations: { () -> Void in
              self!.userImageView.transform = CGAffineTransformMakeScale(1.0, 1.0)
            })
          }
        }
        })
    }
  }
  
  func hireableToText(hireable: Bool?) -> String {
    if let isHireable = hireable {
      if isHireable {
        return "Hireable"
      } else {
        return "Not Currently Hireable"
      }
    } else {
    return ""
    }
  }
  
}
