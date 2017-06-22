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
    var birthdays = [Birthday]()
    private let gregorian = NSCalendar(calendarIdentifier: NSCalendar.Identifier.gregorian)
    var todayComponents: NSDateComponents?
    var today: NSDate? {
        didSet {
            if let today = today {
                todayComponents = gregorian?.components([.month, .day, .year], from: today as Date) as NSDateComponents?
            }
        }
    }

    func registerCellsForTableView(tableView: UITableView) {
        tableView.register(BirthdayCell.self, forCellReuseIdentifier: cellIdentifer)
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return birthdays.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifer, for: indexPath as IndexPath) as! BirthdayCell

        let birthday = birthdays[indexPath.row]
        cell.updateWithItem(item: birthday, progress: progressUntilBirthday(birthday: birthday))

        return cell
    }

    func progressUntilBirthday(birthday: Birthday) -> Float {

        guard let todayComponents = todayComponents else { return 0.0 }

        let calculationComponents = birthday.birthday.copy() as! NSDateComponents
        calculationComponents.year = todayComponents.year

        if calculationComponents.month < todayComponents.month ||
            (calculationComponents.month == todayComponents.month &&
                calculationComponents.day < todayComponents.day) {

            calculationComponents.year += 1 // Swift 3 compliant ...
        }

        let components = gregorian?.components([.day],
                                               from: todayComponents as DateComponents,
                                               to: calculationComponents as DateComponents,
                                               options: [])

        return 1.0-Float(components!.day!)/Float(365)
    }
}

extension BirthdaysListDataProvider {
    func addBirthday(birthday: Birthday) {
        birthdays.append(birthday)
        birthdays.sort { progressUntilBirthday(birthday: $0) > progressUntilBirthday(birthday: $1) }
    }
}
