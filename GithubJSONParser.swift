//
//  GithubJSONParser.swift
//  Week3GithubClient
//
//  Created by User on 4/14/15.
//  Copyright (c) 2015 Craig_Chaillie. All rights reserved.
//

import Foundation

class GithubJSONParser {
  
  class func reposFromJSONData(jsonData: NSData) -> [Repository]?  {
    var repos = [Repository]()
    var jsonError: NSError?
    
    if let
      rootInfo = NSJSONSerialization.JSONObjectWithData(jsonData, options: nil, error: &jsonError) as? [String: AnyObject],
      itemArray = rootInfo["items"] as? [[String: AnyObject]] {
        for repoData in itemArray {
          if let
            name = repoData["name"] as? String,
            userInfo = repoData["owner"] as? [String: AnyObject],
            author = userInfo["login"] as? String,
            htmlURL = repoData["html_url"] as? String,
            description = repoData["description"] as? String
          {
            println(name)
            let repo = Repository(name: name, author: author, htmlUrl: htmlURL, description: description)
            repos.append(repo)
          }
        }
    }
    return repos 
  }
  
  
}