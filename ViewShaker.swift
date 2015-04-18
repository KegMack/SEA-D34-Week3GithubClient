//
//  ViewShaker.swift
//  Week3GithubClient
//
//  Created by User on 4/16/15.
//  Copyright (c) 2015 Craig_Chaillie. All rights reserved.
//


import UIKit

class ViewShaker {
  
  class func shake(viewToShake: UIView)
  {
    let duration = 0.25
    UIView.animateWithDuration(duration, delay: 0.0, usingSpringWithDamping: 0.0, initialSpringVelocity: 10.0, options: UIViewAnimationOptions.BeginFromCurrentState, animations: { () -> Void in
      viewToShake.transform = CGAffineTransformMakeTranslation(3, 0);
      },
      completion: {(finished) -> Void in
        viewToShake.transform = CGAffineTransformMakeTranslation(0, 0);
    })
  }
  
}