//
//  BirthdaysListViewControllerTests.swift
//  Birthdays
//
//  Created by dasdom on 08.08.15.
//  Copyright © 2015 dasdom. All rights reserved.
//

import XCTest
@testable import Birthdays

class BirthdaysListViewControllerTests: XCTestCase {
  
  var viewController: BirthdaysListViewController!
  
  override func setUp() {
    super.setUp()

    viewController = BirthdaysListViewController(style: .Plain)
  }
  
  override func tearDown() {
    // Put teardown code here. This method is called after the invocation of each test method in the class.
    super.tearDown()
  }
  
  func testViewController_HasTableView() {
    XCTAssertNotNil(viewController.tableView)
  }
  
}
