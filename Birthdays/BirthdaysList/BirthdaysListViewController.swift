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

    // MARK: Properties
    var dataProvider: BirthdaysListDataProvider?

    // MARK: LifeCycle

    override func viewDidLoad() {
        super.viewDidLoad()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
        view.backgroundColor = UIColor.red

        // Tell self to get data from the data provider
        tableView.dataSource = dataProvider
        dataProvider?.registerCellsForTableView(tableView: tableView)

        let addButton = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(BirthdaysListViewController.addPerson))
        navigationItem.rightBarButtonItem = addButton
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        dataProvider?.today = NSDate()
    }

    func addPerson() {
        let picker = CNContactPickerViewController()
        picker.delegate = self
        picker.predicateForEnablingContact = NSPredicate(format: "birthday.@count > 0")
        present(picker, animated: true, completion: nil)
    }
}

extension BirthdaysListViewController: CNContactPickerDelegate {
    func contactPicker(_ picker: CNContactPickerViewController, didSelect contact: CNContact){

//        don't need if let because used predicate to only enable with birthday!
//        if let birthday = contact.birthday {
            let person = Birthday(firstName: contact.givenName, lastName: contact.familyName, birthday: contact.birthday! as NSDateComponents)
            print(person)
            dataProvider?.addBirthday(birthday: person)
            tableView.reloadData()
//        }
    }
    func contactPickerDidCancel(_ picker: CNContactPickerViewController) {
        print("Cancel Contact Picker")
    }
}






