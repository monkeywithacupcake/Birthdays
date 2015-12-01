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
  private let gregorian = NSCalendar(calendarIdentifier: NSCalendarIdentifierGregorian)
  var todayComponents: NSDateComponents?
  var today: NSDate? {
    didSet {
      if let today = today {
        todayComponents = gregorian?.components([.Month, .Day, .Year], fromDate: today)
      }
    }
  }
  
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
    
    if let progress = progressUntilBirthday(birthday) {
      cell.updateProgress(progress)
    }
    
    return cell
  }
  
  func progressUntilBirthday(birthday: Birthday) -> Float? {
    let calculationComponents = birthday.birthday
    
    if let todayComponents = todayComponents {
      if calculationComponents.month < todayComponents.month || (calculationComponents.month == todayComponents.month && calculationComponents.day < todayComponents.day) {
        calculationComponents.year = todayComponents.year + 1
      } else {
        calculationComponents.year = todayComponents.year
      }
      
      let components = gregorian?.components([.Day], fromDateComponents: todayComponents, toDateComponents: calculationComponents, options: [])
      
      return 1.0-Float(components!.day)/Float(365)
    } else {
      return nil
    }
  }
}

extension BirthdaysListDataProvider {
  func addBirthday(birthday: Birthday) {
    birthdays.append(birthday)
    birthdays.sortInPlace { progressUntilBirthday($0) > progressUntilBirthday($1) }
  }
}