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
    // Part 1. pick the task/feature to test and locate that view and how to get their from opening the app (step zero)
    func testCreateNewTaskGroup() {
        /*  // steps - open app and get to correct view/screen.
                // first we need the app to launch (open) */
        app.launch()
        /*  walk through the app
                 first thing you see when open similator?
                 we see two profiles, so first we need to select one.
                 so we need to see what we called that accesability identifier.
                 crate variable with specific selection you want */
        let profileCard = app.buttons["ProfileCard_Student"]
        /*    then make sure it is existing why - if we use wifi and it takes
         time so if we don't verify it exists it will try to tap on
         it before it's loaded and fail because it won't exist. */
        XCTAssertTrue(profileCard.exists)
        /*   then you need to add the
action to do on that element if it exists. */
        profileCard.tap()

        /*     Part 2 - when on correct screen/view you can now create the testing.
                 what do we want to do step by step.
                 want user to:
                 step 1. tap add group button
                 step 2. fill out group name
                 step 3. select icon
                 step 4. tap save button */

        
        // step 1.
        let addButton = app.buttons["btn_add_group"]
        // make sure element exists (pass the variable name)
        XCTAssertTrue(addButton.exists)
        // action after element exists is true
        addButton.tap()
        
        /*  step 2.
                 generate new variable for element */
        let nameField = app.textFields["group_name_text_field"]
        // make sure it exists
        XCTAssertTrue(nameField.exists)
        // action to take
        nameField.tap()
        // we add the text we want typed for the test
        nameField.typeText("Testing Adding New Task Group")
        
        /*  step 3.
                 generate new variable for element */
        let iconSelection = app.images["icon_house.fill"]
        // varify it exists
        XCTAssertTrue(iconSelection.exists)
        // action to take
        iconSelection.tap()
        
        /*  step 4
                 generate new variable for element */
        let saveButton = app.buttons["btn_save_new_group"]
        /*  varify it exists

         */
        XCTAssertTrue(saveButton.exists)
        /*   action to take

         */
        saveButton.tap()
        /*  what professor used
                 app.buttons["btn_save_new_group"].tap()


                 part 3 - text the completed expectatioln if all part 2 test is successful

                 it will generate a new group within the content view.
                 make sure it exists */
        XCTAssertTrue(app.buttons["group_link_Testing Adding New Task Group"].exists)
        
        
        
    }
}
