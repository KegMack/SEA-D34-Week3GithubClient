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
            let repo = Repository(name: name, author: author, htmlUrl: htmlURL, description: description)
            repos.append(repo)
          }
        }
    }
    return repos 
  }
  
  class func userReposFromJSONData(jsonData: NSData) -> [Repository]?  {
    var repos = [Repository]()
    var jsonError: NSError?
    
    if let itemArray = NSJSONSerialization.JSONObjectWithData(jsonData, options: nil, error: &jsonError) as? [[String: AnyObject]] {
        for repoData in itemArray {
          if let
            name = repoData["name"] as? String,
            userInfo = repoData["owner"] as? [String: AnyObject],
            author = userInfo["login"] as? String,
            htmlURL = repoData["html_url"] as? String,
            description = repoData["description"] as? String
          {
            let repo = Repository(name: name, author: author, htmlUrl: htmlURL, description: description)
            repos.append(repo)
          }
        }
    }
    return repos
  }

  
  class func usersFromJSONData(jsonData: NSData) -> [User] {
    var users = [User]()
    var error: NSError?
    if let
      jsonInfo = NSJSONSerialization.JSONObjectWithData(jsonData, options: nil, error: &error) as? [String:  AnyObject],
      items = jsonInfo["items"] as? [[String: AnyObject]]   {
        for item in items {
          if let
            login = item["login"] as? String,
            avatarURL = item["avatar_url"] as? String,
            htmlURL = item["html_url"] as? String
          {
            let user = User(name: login, avatarURL: avatarURL, htmlURL: htmlURL)
            users.append(user)
          }
        }
    }
    return users
  }
  
  class func addUserDetailsFromJSONData(user: User, jsonData: NSData) -> User {
    var error: NSError?
    if let
      jsonInfo = NSJSONSerialization.JSONObjectWithData(jsonData, options: nil, error: &error) as? [String: AnyObject] {
        if let bio = jsonInfo["bio"] as? String {
          user.bio = bio
        } else {
          user.bio = "No Bio"
        }
        if let location = jsonInfo["location"] as? String {
          user.location = location
        } else {
          user.location = "Unknown Location"
        }
        if let hireable = jsonInfo["hireable"] as? Bool {
          user.hireable = hireable
        }
    }
    return user
  }
  
  class func myProfileFromJSONData(jsonData: NSData) -> User? {
    var error: NSError?
    if let
      jsonInfo = NSJSONSerialization.JSONObjectWithData(jsonData, options: nil, error: &error) as? [String: AnyObject],
      name = jsonInfo["name"] as? String,
      avatarURL = jsonInfo["avatar_url"] as? String,
      htmlURL = jsonInfo["html_url"] as? String {
        var user = User(name: name, avatarURL: avatarURL, htmlURL: htmlURL)
        if let bio = jsonInfo["bio"] as? String {
          user.bio = bio
        } else {
          user.bio = "No Bio"
        }
        if let location = jsonInfo["location"] as? String {
          user.location = location
        } else {
          user.location = "Unknown Location"
        }
        if let hireable = jsonInfo["hireable"] as? Bool {
          user.hireable = hireable
        }
        return user
    }
    return nil
  }
  
  
}