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
  
  var user: User?
  
  
  override func viewDidLoad() {
    super.viewDidLoad()
    if let image = self.user?.avatarImage {
      self.userImageView.image = image
    }
    // Do any additional setup after loading the view.
  }


}
