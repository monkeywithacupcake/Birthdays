//
//  BirthdaysListDataProvider.swift
//  Birthdays
//
//  Created by dasdom on 16.08.15.
//  Copyright © 2015 dasdom. All rights reserved.
//

import UIKit

class BirthdaysListDataProvider: NSObject, UITableViewDataSource {

  private let cellIdentifer = "Cell"
  
  func registerCellsForTableView(tableView: UITableView) {
    tableView.registerClass(UITableViewCell.self, forCellReuseIdentifier: cellIdentifer)
  }
  
  func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return 10
  }
  
  func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
    let cell = tableView.dequeueReusableCellWithIdentifier(cellIdentifer, forIndexPath: indexPath)
    
    cell.textLabel?.text = "Row: \(indexPath.row)"
    
    return cell
  }
}
