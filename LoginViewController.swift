//
//  LoginViewController.swift
//  Week3GithubClient
//
//  Created by User on 4/14/15.
//  Copyright (c) 2015 Craig_Chaillie. All rights reserved.
//

import UIKit

class LoginViewController: UIViewController {
  
  @IBAction func loginPressed(sender: UIButton) {
    let appDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
    let oAuthService = appDelegate.oAuthService
    oAuthService.requestOAuth { [weak self] () -> () in
      if self != nil {
        let window = appDelegate.window
        let navigationController = self?.storyboard?.instantiateViewControllerWithIdentifier("MainMenuNavigationController") as! UINavigationController
        UIView.transitionFromView(self!.view, toView: navigationController.view, duration: 0.5, options: UIViewAnimationOptions.TransitionCrossDissolve, completion: { (finished) -> Void in
          window?.rootViewController = navigationController
        })
      }
    }
  }

}
