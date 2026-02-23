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
        let saveListButton = app.buttons["SaveListButton"]
        XCTAssertTrue(newListSheet.waitForExistence(timeout: 3.0))
        XCTAssertTrue(saveListButton.waitForExistence(timeout: 3.0))
    }
    
    func testNavigationToListDetail() {
        let firstList = app.buttons.matching(NSPredicate(format: "identifier BEGINSWITH 'List_'")).firstMatch
        XCTAssertTrue(firstList.exists)
        
        firstList.tap()
        
        let detailView = app.buttons["AddItemButton"]
        XCTAssertTrue(detailView.waitForExistence(timeout: 3.0))
    }
    
    func testEditList_ShowFormListView() {
        let firstList = app.buttons.matching(NSPredicate(format: "identifier BEGINSWITH 'List_'")).firstMatch
        XCTAssertTrue(firstList.exists)
        
        firstList.press(forDuration: 1.0)
        
        let editListSheet = app.staticTexts["FormListTitle"]
        let nameTextField = app.textFields["ListNameTextField"]
        let saveListButton = app.buttons["SaveListButton"]

        XCTAssertTrue(editListSheet.waitForExistence(timeout: 3.0))
        XCTAssertTrue(nameTextField.waitForExistence(timeout: 3.0))
        XCTAssertTrue(saveListButton.waitForExistence(timeout: 3.0))
        XCTAssertEqual(nameTextField.value as? String, "Lista 1")
    }
    
    // NOTE: Review test in case the alert title changes
    func testDeleteButtonShowsAlert() {
        let firstList = app.buttons.matching(NSPredicate(format: "identifier BEGINSWITH 'List_'")).firstMatch
        XCTAssertTrue(firstList.exists)
        
        firstList.press(forDuration: 1.0)
        
        let deleteButton = app.buttons["DeleteListButton"]
        XCTAssertTrue(deleteButton.waitForExistence(timeout: 3.0))
        
        deleteButton.tap()
        XCTAssertTrue(app.alerts["Eliminar lista"].waitForExistence(timeout: 3.0))
    }
    
    func testListDetailView_ShowItems() {
        let firstList = app.buttons.matching(NSPredicate(format: "identifier BEGINSWITH 'List_'")).firstMatch
        XCTAssertTrue(firstList.exists)
        
        firstList.tap()
        
        let firstItem = app.staticTexts.matching(NSPredicate(format: "identifier BEGINSWITH 'Item_'")).firstMatch
        XCTAssertTrue(firstItem.waitForExistence(timeout: 3.0))
    }
    
    func testNavigationToFormItem() {
        let firstList = app.buttons.matching(NSPredicate(format: "identifier BEGINSWITH 'List_'")).firstMatch
        XCTAssertTrue(firstList.exists)
        
        firstList.tap()
        
        let addItemButton = app.buttons["AddItemButton"]
        XCTAssertTrue(addItemButton.waitForExistence(timeout: 3.0))
        
        addItemButton.tap()
        
        let saveItemButton = app.buttons["SaveItemButton"]
        XCTAssertTrue(saveItemButton.waitForExistence(timeout: 3.0))
    }
    
    func testEditItem_ShowFormItemView() {
        let firstList = app.buttons.matching(NSPredicate(format: "identifier BEGINSWITH 'List_'")).firstMatch
        XCTAssertTrue(firstList.exists)
        
        firstList.tap()
        
        let firstItem = app.staticTexts.matching(NSPredicate(format: "identifier BEGINSWITH 'Item_'")).firstMatch
        XCTAssertTrue(firstItem.waitForExistence(timeout: 3.0))
        
        firstItem.tap()
        
        let editItemSheet = app.staticTexts["FormItemTitle"]
        let nameTextField = app.textFields["ItemNameTextField"]
        let saveItemButton = app.buttons["SaveItemButton"]
        
        XCTAssertTrue(editItemSheet.waitForExistence(timeout: 3.0))
        XCTAssertTrue(nameTextField.waitForExistence(timeout: 3.0))
        XCTAssertTrue(saveItemButton.waitForExistence(timeout: 3.0))
        XCTAssertEqual(nameTextField.value as? String, "Producto 1")
    }
}
