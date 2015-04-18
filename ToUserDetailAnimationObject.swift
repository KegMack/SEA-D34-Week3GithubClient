//
//  ToUserDetailAnimationObject.swift
//  Week3GithubClient
//
//  Created by User on 4/15/15.
//  Copyright (c) 2015 Craig_Chaillie. All rights reserved.
//

import UIKit

class ToUserDetailAnimationObject: NSObject, UIViewControllerAnimatedTransitioning
{
  
  let animationDuration = 2.0
  let keyFrameDuration: Double = 1/6
  
  func transitionDuration(transitionContext: UIViewControllerContextTransitioning) -> NSTimeInterval {
    return self.animationDuration
  }
  
  func animateTransition(transitionContext: UIViewControllerContextTransitioning)
  {
    let presentingVC = transitionContext.viewControllerForKey(UITransitionContextFromViewControllerKey) as! UserSearchViewController
    let destinationVC = transitionContext.viewControllerForKey(UITransitionContextToViewControllerKey) as! UserDetailViewController
    let containerView = transitionContext.containerView()
    
    destinationVC.view.alpha = 0
    containerView.addSubview(destinationVC.view)
    
    let selectedIndexPath = presentingVC.collectionView.indexPathsForSelectedItems().first as! NSIndexPath
    let userCell = presentingVC.collectionView.cellForItemAtIndexPath(selectedIndexPath) as! UserCollectionViewCell
    let snapShot = userCell.imageView.snapshotViewAfterScreenUpdates(false)
    userCell.hidden = true
    snapShot.frame = containerView.convertRect(userCell.imageView.frame, fromCoordinateSpace: userCell.imageView.superview!)
    containerView.addSubview(snapShot)
    destinationVC.view.layoutIfNeeded()
    let destinationImageFrame = containerView.convertRect(destinationVC.userImageView.frame, fromView: destinationVC.view)
    destinationVC.userImageView.hidden = true
    
    UIView.animateKeyframesWithDuration(self.animationDuration, delay: 0, options: UIViewKeyframeAnimationOptions.allZeros, animations: { () -> Void in
      UIView.addKeyframeWithRelativeStartTime(0, relativeDuration: 1, animations: { () -> Void in
        destinationVC.view.alpha = 1
        snapShot.frame = destinationImageFrame
      })
      UIView.addKeyframeWithRelativeStartTime(0, relativeDuration: self.keyFrameDuration, animations: { () -> Void in
        snapShot.transform = CGAffineTransformMakeRotation(CGFloat(M_PI/3))
      })
      UIView.addKeyframeWithRelativeStartTime(self.keyFrameDuration, relativeDuration:self.keyFrameDuration , animations: { () -> Void in
        snapShot.transform = CGAffineTransformMakeRotation(CGFloat(2*M_PI/3))
      })
      UIView.addKeyframeWithRelativeStartTime(2*self.keyFrameDuration, relativeDuration: self.keyFrameDuration, animations: { () -> Void in
        snapShot.transform = CGAffineTransformMakeRotation(CGFloat(M_PI))
      })
      UIView.addKeyframeWithRelativeStartTime(3*self.keyFrameDuration, relativeDuration: self.keyFrameDuration, animations: { () -> Void in
        snapShot.transform = CGAffineTransformMakeRotation(CGFloat(4*M_PI/3))
      })
      UIView.addKeyframeWithRelativeStartTime(4*self.keyFrameDuration, relativeDuration:self.keyFrameDuration , animations: { () -> Void in
        snapShot.transform = CGAffineTransformMakeRotation(CGFloat(5*M_PI/3))
      })
      UIView.addKeyframeWithRelativeStartTime(5*self.keyFrameDuration, relativeDuration: self.keyFrameDuration, animations: { () -> Void in
        snapShot.transform = CGAffineTransformMakeRotation(CGFloat(2*M_PI))
      })
      }) { (finished) -> Void in
        if finished {
          destinationVC.userImageView.hidden = false
          snapShot.removeFromSuperview()
          userCell.hidden = false
          transitionContext.completeTransition(true)
        } else {
          transitionContext.completeTransition(false)
        }
    }
  }
  
}


