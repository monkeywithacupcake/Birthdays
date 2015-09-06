//
//  BirthdaysListViewController.swift
//  Birthdays
//
//  Created by dasdom on 08.08.15.
//  Copyright © 2015 dasdom. All rights reserved.
//

import UIKit
import ContactsUI

class BirthdaysListViewController: UITableViewController {
  
  var dataProvider: BirthdaysListDataProvider?
  
  override func viewDidLoad() {
    
    tableView.dataSource = dataProvider
    
    dataProvider?.registerCellsForTableView(tableView)
    
    let addButton = UIBarButtonItem(barButtonSystemItem: .Add, target: self, action: "addPerson")
    navigationItem.rightBarButtonItem = addButton
    
  }
  
  func addPerson() {
    let picker = CNContactPickerViewController()
    picker.delegate = self
    presentViewController(picker, animated: true, completion: nil)
  }
}

extension BirthdaysListViewController: CNContactPickerDelegate {
  func contactPicker(picker: CNContactPickerViewController, didSelectContact contact: CNContact) {
  
    if let birthday = contact.birthday {
      let person = Birthday(firstName: contact.givenName, lastName: contact.familyName, birthday: birthday)
      print(person)
      dataProvider?.addBirthday(person)
      tableView.reloadData()
    }
  }
}
