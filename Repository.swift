//
//  Repository.swift
//  Week3GithubClient
//
//  Created by User on 4/14/15.
//  Copyright (c) 2015 Craig_Chaillie. All rights reserved.
//

import Foundation

struct Repository {
  
  var name: String
  var author: String
  var htmlUrl: String
  var description: String
  
  init(name: String, author: String, htmlUrl: String, description: String)  {
    self.name = name
    self.author = author
    self.htmlUrl = htmlUrl
    self.description = description
  }
  
}