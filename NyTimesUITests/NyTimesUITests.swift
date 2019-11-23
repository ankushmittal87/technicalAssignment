//
//  NyTimesUITests.swift
//  NyTimesUITests
//
//  Created by Ankush Mittal on 20/11/19.
//  Copyright © 2019 Ankush Mittal. All rights reserved.
//

import XCTest
import UIKit

class NyTimesUITests: XCTestCase {

    override func setUp() {
        // Put setup code here. This method is called before the invocation of each test method in the class.

        // In UI tests it is usually best to stop immediately when a failure occurs.
        continueAfterFailure = false

        // UI tests must launch the application that they test.
        // Doing this in setup will make sure it happens for each test method.
        XCUIApplication().launch()

        // In UI tests it’s important to set the initial state - such as interface
        // orientation - required for your tests before they run.
        // The setUp method is a good place to do this.
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }
//    func testDetailByIndex() {
//        let app = XCUIApplication()
//        let newsTable = app.tables["mostPopularNewsTable"]
//        newsTable.cells.element(boundBy: 0).tap()
//        app.navigationBars["Detail"].buttons["NY Times Most Popular"].tap()
//    }
    
    func testTableExists()  {
        let app = XCUIApplication()
        let newsTable = app.tables["mostPopularNewsTable"]
        let exists = newsTable.waitForExistence(timeout: 5)
        XCTAssert(exists)
    }
    func testTableClickAndReturnWithServiceAvailability() {
        let expectation = XCTestExpectation(description: "News table cell count should be greater than 1")
        let url = URL(string: "https://api.nytimes.com/svc/mostpopular/v2/viewed/7.json?api-key=knM117ii5SfjSzXxV4ePqYEvRhYp9Epb")!
        let dataTask = URLSession.shared.dataTask(with: url) { (data, _, _) in
            
            DispatchQueue.main.async {
                let app = XCUIApplication()
                let newsTable = app.tables["mostPopularNewsTable"]
                newsTable.cells.element(boundBy: 0).tap()
                app.navigationBars["Detail"].buttons["NY Times Most Popular"].tap()
                XCTAssertNotNil(data, "Service ping faild.")
                expectation.fulfill()
            }
        }
        dataTask.resume()
        wait(for: [expectation], timeout: 5)
    }
}
