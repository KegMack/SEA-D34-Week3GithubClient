//
//  User.swift
//  Week3GithubClient
//
//  Created by User on 4/15/15.
//  Copyright (c) 2015 Craig_Chaillie. All rights reserved.
//

import UIKit

class User {
  
  var name: String
  var avatarURL: String
  var htmlURL: String
  var avatarImage: UIImage?
  
  init(name: String, avatarURL: String, htmlURL: String) {
    self.name = name
    self.avatarURL = avatarURL
    self.htmlURL = htmlURL
  }
  
}
