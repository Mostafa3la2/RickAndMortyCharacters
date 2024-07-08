//
//  RickAndMortyCharactersUITests.swift
//  RickAndMortyCharactersUITests
//
//  Created by Mostafa Alaa on 04/07/2024.
//

import XCTest
final class RickAndMortyCharactersUITests: XCTestCase {

    override func setUp() {
        // Put setup code here. This method is called before the invocation of each test method in the class.

        // In UI tests it is usually best to stop immediately when a failure occurs.
        continueAfterFailure = false

        XCUIApplication().launch()
    }

    override func tearDown() {
        super.tearDown()
    }

    func testNavigationToDetailView() {
        let app = XCUIApplication()

        let charactersTableView = app.tables.firstMatch

        // Wait until the table view is loaded
        let exists = NSPredicate(format: "exists == true")
        expectation(for: exists, evaluatedWith: charactersTableView, handler: nil)
        waitForExpectations(timeout: 5)

        // Tap the first cell
        let firstCell = charactersTableView.cells.element(boundBy: 0)
        XCTAssertTrue(firstCell.exists, "The first cell is not found")
        firstCell.tap()

        // Verify that the back button is displayed and working
        let backButton = app.buttons["back"]
        XCTAssertTrue(backButton.exists, "The back button exists")
        backButton.tap()

        // Verify we are actually back and the header view exists
        let headerView = charactersTableView.otherElements["filterHeaderView"]
        expectation(for: exists, evaluatedWith: headerView)
        waitForExpectations(timeout: 5)
    }
}
