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
    print(birthday)
    if let today = today, todayComponents = todayComponents, _ = birthday.birthday.date {
      let calculationComponents = birthday.birthday.copy() as! NSDateComponents
      calculationComponents.year = todayComponents.year
      if gregorian!.compareDate(today, toDate: calculationComponents.date!, toUnitGranularity: .Day) == .OrderedDescending {
        calculationComponents.year += 1 // Swift 3 compliant ...
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