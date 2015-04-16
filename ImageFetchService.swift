//
//  ImageFetchService.swift
//  Week3GithubClient
//
//  Created by User on 4/15/15.
//  Copyright (c) 2015 Craig_Chaillie. All rights reserved.
//

import UIKit

class ImageFetchService {
  
  let imageQueue = NSOperationQueue()
  
  func fetchImageFromURL(url: String, completionHandler: (UIImage?) -> (Void)) {
    self.imageQueue.addOperationWithBlock { () -> Void in
      if let
        imageUrl = NSURL(string: url),
        imageData = NSData(contentsOfURL: imageUrl) {
          let image = UIImage(data: imageData)
          NSOperationQueue.mainQueue().addOperationWithBlock({ () -> Void in
            completionHandler(image)
          })
      }
    }
  }
}
