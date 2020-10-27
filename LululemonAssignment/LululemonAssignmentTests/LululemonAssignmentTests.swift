//
//  LululemonAssignmentTests.swift
//  LululemonAssignmentTests
//
//  Created by Eugene Berezin on 10/27/20.
//

import XCTest
import CoreData
@testable import LululemonAssignment

class LululemonAssignmentTests: XCTestCase {
    
    let viewModel = GarmentViewModel()

    override func setUpWithError() throws {}

    override func tearDownWithError() throws {
        viewModel.garmentsList.removeAll()
       
    }

    func testAddItem() throws {
        viewModel.saveData(garmentName: "Unit test")
        viewModel.retrieveData()
        XCTAssert(viewModel.garmentsList.contains(where: { (garment) -> Bool in
            garment.garmentName == "Unit test"
        }))
    }
    
    func testGarmentList() {
        viewModel.saveData(garmentName: "Testing")
        viewModel.retrieveData()
        XCTAssertFalse(viewModel.garmentsList.isEmpty)
    }
    
    func testListVC() {
        let window = UIWindow()
        let listVC = ListViewController()
        window.addSubview(listVC.view)
        listVC.viewDidLoad()
        XCTAssertNotNil(listVC.tableView)
        XCTAssertEqual(listVC.title, "List")
        XCTAssertNotNil(listVC.navigationItem.rightBarButtonItem)
        XCTAssertNotNil(listVC.segmentedControl)
    }
    
    func testAddVC() {
        let window = UIWindow()
        let addVC = AddViewController()
        window.addSubview(addVC.view)
        XCTAssertNotNil(addVC.label)
        XCTAssertNotNil(addVC.textField)
        XCTAssertNotNil(addVC.navigationItem.rightBarButtonItem)
    }

}
