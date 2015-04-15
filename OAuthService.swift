//
//  OAuthService.swift
//  Week3GithubClient
//
//  Created by User on 4/14/15.
//  Copyright (c) 2015 Craig_Chaillie. All rights reserved.
//

import UIKit

class OAuthService {
  
  var oauthRequestCompletionHandler : (() -> ())?
  
  func requestOAuth(completionHandler : () -> ()) {
    self.oauthRequestCompletionHandler = completionHandler
    let oAuthURL = "https://github.com/login/oauth/authorize?client_id=\(kGithubClientID)&scope=user,public_repo"
    UIApplication.sharedApplication().openURL(NSURL(string: oAuthURL)!)
  }
  
  func handleRedirect(url : NSURL) {
    
    let oAuthCode = url.query
    let redirectUrl = "https://github.com/login/oauth/access_token"
    let parameters = "\(oAuthCode!)&client_id=\(kGithubClientID)&client_secret=\(kGithubClientSecret)"
    let data = parameters.dataUsingEncoding(NSASCIIStringEncoding, allowLossyConversion: true)
    
    let request = NSMutableURLRequest(URL: NSURL(string: redirectUrl)!)
    request.HTTPMethod = "POST"
    request.HTTPBody = data
    request.setValue("application/json", forHTTPHeaderField: "Accept")
    request.setValue("\(data!.length)", forHTTPHeaderField: "Content-Length")
    request.setValue("application/x-www-form-urlencoded", forHTTPHeaderField: "Content-Type")
    
    let dataTask = NSURLSession.sharedSession().dataTaskWithRequest(request, completionHandler: { (data, response, error) -> Void in
      if error != nil {
        println("Error: OAuthService unable to perform request. \(error)")
      }
      else if data != nil {
        if let jsonDictionary = NSJSONSerialization.JSONObjectWithData(data, options: nil, error: nil) as? [String : AnyObject] {
          if let token = jsonDictionary["access_token"] as? String {
            println("Token: \(token)")
            NSUserDefaults.standardUserDefaults().setObject(token, forKey: kUserDefaultTokenKey)
            NSUserDefaults.standardUserDefaults().synchronize()
            NSOperationQueue.mainQueue().addOperationWithBlock({ () -> Void in
              self.oauthRequestCompletionHandler!()
            })
          }
        }
      }
    })
    dataTask.resume()
  }
  
}