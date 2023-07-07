//
//  Netflix_CloneUITests.swift
//  Netflix CloneUITests
//
//  Created by Olanrewaju Olakunle  on 15/10/2022.
//

import XCTest

class Netflix_CloneUITests: XCTestCase {

    func testTheSearchPage(){
        
        let app = XCUIApplication()
        app.launch()
        
        let topSearchButton = app.tabBars["Tab Bar"].buttons["Top Search"]
        let searchNavigationBar = app.navigationBars["Search"]
        let searchForAMovieOrTvShowSearchField = searchNavigationBar.searchFields["Search for a Movie or Tv Show"]
        let sKey = app/*@START_MENU_TOKEN@*/.keys["S"]/*[[".keyboards.keys[\"S\"]",".keys[\"S\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/
        let pKey = app/*@START_MENU_TOKEN@*/.keys["p"]/*[[".keyboards.keys[\"p\"]",".keys[\"p\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/
        let iKey = app/*@START_MENU_TOKEN@*/.keys["i"]/*[[".keyboards.keys[\"i\"]",".keys[\"i\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/
        let dKey = app/*@START_MENU_TOKEN@*/.keys["d"]/*[[".keyboards.keys[\"d\"]",".keys[\"d\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/
        let eKey = app/*@START_MENU_TOKEN@*/.keys["e"]/*[[".keyboards.keys[\"e\"]",".keys[\"e\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/
        let rKey = app/*@START_MENU_TOKEN@*/.keys["r"]/*[[".keyboards.keys[\"r\"]",".keys[\"r\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/
        let spaceKey = app/*@START_MENU_TOKEN@*/.keys["space"]/*[[".keyboards.keys[\"space\"]",".keys[\"space\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/
        let mKey = app/*@START_MENU_TOKEN@*/.keys["m"]/*[[".keyboards.keys[\"m\"]",".keys[\"m\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/
        let aKey = app/*@START_MENU_TOKEN@*/.keys["a"]/*[[".keyboards.keys[\"a\"]",".keys[\"a\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/
        let nKey = app/*@START_MENU_TOKEN@*/.keys["n"]/*[[".keyboards.keys[\"n\"]",".keys[\"n\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/
        let keypadSearchButton = app/*@START_MENU_TOKEN@*/.buttons["search"]/*[[".keyboards",".buttons[\"search\"]",".buttons[\"Search\"]"],[[[-1,1],[-1,0,1]],[[-1,2],[-1,1]]],[0]]@END_MENU_TOKEN@*/
        let searchResult = app/*@START_MENU_TOKEN@*/.collectionViews["Search results"]/*[[".otherElements[\"Double-tap to dismiss\"].collectionViews[\"Search results\"]",".collectionViews[\"Search results\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/.children(matching: .cell).element(boundBy: 0).children(matching: .other).element
        
        let navBarSearchButton = searchNavigationBar.buttons["Search"]
        
        let clearTextsButton = searchForAMovieOrTvShowSearchField.buttons["Clear text"]
        
        let navBarCancelButton = searchNavigationBar.buttons["Cancel"]
        
        
        topSearchButton.tap()
        searchForAMovieOrTvShowSearchField.tap()
        sKey.tap()
        pKey.tap()
        iKey.tap()
        dKey.tap()
        eKey.tap()
        rKey.tap()
        spaceKey.tap()
        mKey.tap()
        aKey.tap()
        nKey.tap()
        keypadSearchButton.tap()
        searchResult.tap()
        XCTAssertTrue(searchResult.exists)
        navBarSearchButton.tap()
        clearTextsButton.tap()
        navBarCancelButton.tap()
        
    }
    
    func testTheDownloadFeature(){
        let app = XCUIApplication()
        app.launch()
        let tablesQuery = app.tables
        let downloadButton = app.collectionViews/*@START_MENU_TOKEN@*/.buttons["Download"]/*[[".cells.buttons[\"Download\"]",".buttons[\"Download\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/
        let downloadTabBar = app.tabBars["Tab Bar"].buttons["Downloads"]
        let downloadsNavigationBar = app.navigationBars["Downloads"]
        let cellsQuery = app.tables.cells
        let downloadedMovie = cellsQuery.children(matching: .other).element(boundBy: 0)
        let backButton = downloadsNavigationBar.buttons["Downloads"]
        
        
        tablesQuery.children(matching: .cell).element(boundBy: 0).collectionViews.children(matching: .cell).element(boundBy: 0).children(matching: .other).element/*@START_MENU_TOKEN@*/.press(forDuration: 1.5);/*[[".tap()",".press(forDuration: 1.5);"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/
        downloadButton.tap()
        downloadTabBar.tap()
        
        
        XCTAssertTrue(downloadedMovie.exists)
        downloadedMovie.tap()
        backButton.tap()
    }
    
    func testTheDownloadAndDeleteFeatures(){
         
            let app = XCUIApplication()
            app.launch()
            let tablesQuery = app.tables
            let downloadButton = app.collectionViews/*@START_MENU_TOKEN@*/.buttons["Download"]/*[[".cells.buttons[\"Download\"]",".buttons[\"Download\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/
            let downloadTabBar = app.tabBars["Tab Bar"].buttons["Downloads"]
            _ = app.navigationBars["Downloads"]
            let cellsQuery = app.tables.cells


            tablesQuery.children(matching: .cell).element(boundBy: 0).collectionViews.children(matching: .cell).element(boundBy: 0).children(matching: .other).element/*@START_MENU_TOKEN@*/.press(forDuration: 1.5);/*[[".tap()",".press(forDuration: 1.5);"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/
            downloadButton.tap()
            downloadTabBar.tap()
            cellsQuery.children(matching: .other).element(boundBy: 0)
            //downloadsNavigationBar.buttons["Downloads"].tap()
            cellsQuery.children(matching: .other).element(boundBy: 0).tap()
            cellsQuery.children(matching: .other).element(boundBy: 0).swipeLeft()
            tablesQuery/*@START_MENU_TOKEN@*/.buttons["Delete"]/*[[".cells.buttons[\"Delete\"]",".buttons[\"Delete\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/.tap()
        }
    
}

/*   override func setUpWithError() throws {
       // Put setup code here. This method is called before the invocation of each test method in the class.

       // In UI tests it is usually best to stop immediately when a failure occurs.
       continueAfterFailure = false

       // In UI tests it’s important to set the initial state - such as interface orientation - required for your tests before they run. The setUp method is a good place to do this.
   }

   override func tearDownWithError() throws {
       // Put teardown code here. This method is called after the invocation of each test method in the class.
   }

   func testExample() throws {
       // UI tests must launch the application that they test.
       let app = XCUIApplication()
       app.launch()

       // Use recording to get started writing UI tests.
       // Use XCTAssert and related functions to verify your tests produce the correct results.
   }

   func testLaunchPerformance() throws {
       if #available(macOS 10.15, iOS 13.0, tvOS 13.0, watchOS 7.0, *) {
           // This measures how long it takes to launch your application.
           measure(metrics: [XCTApplicationLaunchMetric()]) {
               XCUIApplication().launch()
           }
       }
   }*/
