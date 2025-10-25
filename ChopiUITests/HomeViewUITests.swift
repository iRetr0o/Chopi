//
//  HomeViewUITests.swift
//  ChopiUITests
//
//  Created by Oscar Gutierrez on 24/10/25.
//

import XCTest

final class HomeViewUITests: XCTestCase {
    var app: XCUIApplication!
    
    override func setUpWithError() throws {
        continueAfterFailure = false
        app = XCUIApplication()
        app.launchArguments.append("-UITests")
        app.launch()
    }
    
    override func tearDownWithError() throws {
        app = nil
    }

    func testHomeView_ElementsExist() {
        let addListButton = app.buttons["AddListButton"]
        XCTAssertTrue(addListButton.exists)
        
        let listElement = app.staticTexts["ListElement"]
        XCTAssertTrue(listElement.exists)
    }
}
