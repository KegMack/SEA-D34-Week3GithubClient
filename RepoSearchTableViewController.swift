//
//  RepoSearchTableViewController.swift
//  Week3GithubClient
//
//  Created by User on 4/14/15.
//  Copyright (c) 2015 Craig_Chaillie. All rights reserved.
//

import UIKit

class RepoSearchTableViewController: UITableViewController, UISearchBarDelegate {

  @IBOutlet weak var searchBar: UISearchBar!
  let githubService = GithubService.defaultService
  var repos = [Repository]()
  
  
  // MARK: - Table view data source
  
  override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
    return 1
  }
  
  override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return self.repos.count
  }
  
  override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
    let cell = tableView.dequeueReusableCellWithIdentifier("repoSearchCell", forIndexPath: indexPath) as! UITableViewCell
    cell.textLabel!.text = self.repos[indexPath.row].name
    return cell
  }
  
  // MARK: SearchBar Delegation
  
  func searchBar(searchBar: UISearchBar, shouldChangeTextInRange range: NSRange, replacementText text: String) -> Bool {
    let valid = text.validForURL()
    if valid {
      return true
    } else {
      ViewShaker.shake(searchBar)
      return false
    }
  }
  
  func searchBarSearchButtonClicked(searchBar: UISearchBar) {
    searchBar.resignFirstResponder()
    self.githubService.fetchRepositories(searchBar.text, completionHandler: { (newRepos, error) -> (Void) in
      if error != nil {
        println("Error: \(error)")
      }
      else if newRepos != nil {
        self.repos = newRepos!
        self.tableView.reloadData()
      }
    })
  }
  
  // MARK: Segue
  
  override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
    if segue.identifier == "RepoSegue" {
      if let destinationVC = segue.destinationViewController as? WebViewController {
        let indexPath = self.tableView.indexPathForSelectedRow()
        destinationVC.repo = self.repos[indexPath!.row]
      }
    }
  }
  
  
  
}
