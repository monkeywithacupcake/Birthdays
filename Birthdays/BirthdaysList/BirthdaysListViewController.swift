//
//  BirthdaysListViewController.swift
//  Birthdays
//
//  Created by dasdom on 08.08.15.
//  Copyright © 2015 dasdom. All rights reserved.
//

import UIKit

class BirthdaysListViewController: UITableViewController {

  var dataProvider: BirthdaysListDataProvider?
  
  override func viewDidLoad() {
    view.backgroundColor = .redColor()
    
    tableView.dataSource = dataProvider

    dataProvider?.registerCellsForTableView(tableView)
  }
}
