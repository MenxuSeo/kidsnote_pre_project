//
//  kidsnote_pre_projectUITests.swift
//  kidsnote_pre_projectUITests
//
//  Created by seo on 28/7/24.
//

import XCTest

final class kidsnote_pre_projectUITests: XCTestCase {
  func testNavigation() {
    // Given
    let app = XCUIApplication()
    app.launch()
    
    // When
    app.searchFields.firstMatch.tap()
    app.searchFields.firstMatch.typeText("1")
    
    let firstBookCell = app.tables.cells.firstMatch
    XCTAssertTrue(firstBookCell.waitForExistence(timeout: 5))
    firstBookCell.tap()
    
    // Then
    XCTAssertTrue(app.staticTexts["Book Details"].exists)
    XCTAssertTrue(app.staticTexts["건곤쟁패 1권"].exists)
  }
}
