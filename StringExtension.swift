//
//  StringExtension.swift
//  Week3GithubClient
//
//  Created by User on 4/16/15.
//  Copyright (c) 2015 Craig_Chaillie. All rights reserved.
//

import Foundation

extension String {
  
  func validForURL()-> Bool {
    let numberOfChars = count(self)
    let range = NSMakeRange(0, numberOfChars)
    let regex = NSRegularExpression(pattern: "[^0-9a-zA-Z\n-]", options: nil, error: nil)
    let matches = regex?.numberOfMatchesInString(self, options: nil, range: range)
    if matches > 0 {
      return false
    }
    return true
  }
  
}