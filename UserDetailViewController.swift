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
  
  override func viewDidLoad() {
    super.viewDidLoad()
    if let image = self.user?.avatarImage {
      self.userImageView.image = image
    }
    if let validUser = self.user {
      GithubService.defaultService.fetchUserInfo(validUser, completionHandler: { [weak self] (user, error) -> (Void) in
        if error != nil {
          println(error)
        }
        else {
          if self != nil {
            self!.user = validUser
            self!.nameLabel.text = self!.user?.name
            self!.locationLabel.text = self!.user?.location
            self!.bioLabel.text = self!.user?.bio
            self!.hireableLabel.text = self!.hireableText(self!.user?.hireable)
          }
        }
      })
    }
  }
  
  func hireableText(hireable: Bool?) -> String {
    
    if let isHireable = hireable {
      if isHireable {
        return "Currently Hireable"
      } else {
        return "Not Currently Hireable"
      }
    } else {
    return ""
    }
  }
  
}
