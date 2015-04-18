//
//  WebViewController.swift
//  Week3GithubClient
//
//  Created by User on 4/16/15.
//  Copyright (c) 2015 Craig_Chaillie. All rights reserved.
//

import UIKit
import WebKit

class WebViewController: UIViewController {
  
  var webView: WKWebView!
  var repo: Repository!
  
  override func viewDidLoad() {
    super.viewDidLoad()
    self.webView = WKWebView(frame: self.view.frame)
    self.view.addSubview(self.webView)
    constrainView(self.webView, toContainer: self.view)
    self.webView.loadRequest(NSURLRequest(URL: NSURL(string: self.repo.htmlUrl)!))
    self.webView.setTranslatesAutoresizingMaskIntoConstraints(false)
  }
  
  func constrainView(child: UIView, toContainer container: UIView) {
    var top = NSLayoutConstraint(item: child, attribute: NSLayoutAttribute.Top, relatedBy: .Equal, toItem: container, attribute: NSLayoutAttribute.TopMargin, multiplier: 1.0, constant: 0)
    container.addConstraint(top)
    var bottom = NSLayoutConstraint(item: child, attribute: NSLayoutAttribute.Bottom, relatedBy: .Equal, toItem:
      container, attribute: NSLayoutAttribute.BottomMargin, multiplier: 1.0, constant: 0)
    container.addConstraint(bottom)
    var left = NSLayoutConstraint(item: child, attribute: .LeadingMargin, relatedBy: .Equal, toItem: container, attribute: .Leading, multiplier: 1.0, constant: 0.0)
    container.addConstraint(left)
    var right = NSLayoutConstraint(item: child, attribute: .TrailingMargin, relatedBy: .Equal, toItem: container, attribute: .Trailing, multiplier: 1.0, constant: 0)
    container.addConstraint(right)
  }
 
}
