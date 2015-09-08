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
  private var birthdays = [Birthday]()
  
  func registerCellsForTableView(tableView: UITableView) {
    tableView.registerClass(BirthdayCell.self, forCellReuseIdentifier: cellIdentifer)
  }
  
  func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return birthdays.count
  }
  
  func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
    let cell = tableView.dequeueReusableCellWithIdentifier(cellIdentifer, forIndexPath: indexPath) as! BirthdayCell
    
    let birthday = birthdays[indexPath.row]
    cell.nameLabel.text = birthday.firstName
    cell.patternNameLabel.text = birthday.firstName
    cell.birthdayLabel.text = "\(birthday.birthday.day) \(birthday.birthday.month)"
    
    return cell
  }
}

extension BirthdaysListDataProvider {
  func addBirthday(birthday: Birthday) {
    birthdays.append(birthday)
  }
}