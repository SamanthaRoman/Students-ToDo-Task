//
//
//
//
//
//

import XCTest

final class ToDo_TaskUITests: XCTestCase {
    let app = XCUIApplication()

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.

        // In UI tests it is usually best to stop immediately when a failure occurs.
        continueAfterFailure = false

        // In UI tests it’s important to set the initial state - such as interface orientation - required for your tests before they run. The setUp method is a good place to do this.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    // test translation of text - english
    func testLaunchInEnglish() {
        //1. force app to launch in a language
        app.launchArguments = ["-AppleLanguages", "(en)"] // tell it what language to test
        app.launch() // open application
        
        // look for specific string/text... we will look at main header when app opens
        let header = app.staticTexts["Who is working today?"]    // text must be exactly as is seen on the screen
        // then we must varify if it exists. so bool - true or false
        XCTAssertTrue(header.exists, "The english header was not found")
    }
    
    // test translation of spanish
    func testLaunchInSpanish() {
        //1. force app to launch in a language
        app.launchArguments = ["-AppleLanguages", "(es)"] // tell it what language to test
        app.launch() // open application
        
        // look for specific string/text... we will look at main header when app opens
        let header = app.staticTexts["¿Quién está trabajando hoy?"]    // text must be exactly as is seen on the screen - find string in localizable file
        // then we must varify if it exists. so bool - true or false
        XCTAssertTrue(header.exists, "The spanish header was not found")
    }
    
    // Creating a test for a UI feature.
    // 1. pick the task/feature to test
    func testCreateNewTaskGroup() {
        // first we need the app to launch (open)
        app.launch()
        // walk through the app
        // first thing you see when open similator?
        // we see two profiles, so first we need to select one.
        // so we need to see what we called that accesability identifier.
        
    }
}
