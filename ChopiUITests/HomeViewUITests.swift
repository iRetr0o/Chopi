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
    }
    
    func testAddList_ShowFormListView() {
        let addListButton = app.buttons["AddListButton"]
        XCTAssertTrue(addListButton.exists)
        
        addListButton.tap()
        
        let newListSheet = app.staticTexts["FormListTitle"]
        XCTAssertTrue(newListSheet.waitForExistence(timeout: 3.0))
    }
    
    func testNavigationToListDetail() {
        let firstList = app.buttons.matching(NSPredicate(format: "identifier BEGINSWITH 'List_'")).firstMatch
        XCTAssertTrue(firstList.exists)
        
        firstList.tap()
        
        let detailView = app.buttons["AddItemButton"]
        XCTAssertTrue(detailView.waitForExistence(timeout: 3.0))
    }
}
