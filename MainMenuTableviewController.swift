//
//  MainMenuTableviewController.swift
//  
//
//  Created by User on 4/14/15.
//
//

import UIKit

class MainMenuTableviewController: UITableViewController {

  override func viewDidLoad() {
    super.viewDidLoad()
  }

  override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
    if segue.identifier == "myProfileSegue" {
      if let userDetailVC = segue.destinationViewController as? UserDetailViewController {
        
      }
    }
  }

}
