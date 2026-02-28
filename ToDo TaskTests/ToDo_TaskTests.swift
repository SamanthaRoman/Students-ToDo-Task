//
//  ToDo_TaskTests.swift
//  ToDo TaskTests
//
//  Created by Gabriela Sanchez on 09/12/25.
//

import XCTest
@testable import ToDo_Task


class ToDo_TaskTests: XCTestCase { // contain all different test cases here
    
    // Function always starts with word "test" followed by what your testing. Specific
    func testProgressCalculation() {
        // ARRANGE : have all the variables we need to make the test work
        // look at model
        
        let tasks = [
            TaskItem(title: "test1", isCompleted: false),
            TaskItem(title: "test2", isCompleted: true),
            TaskItem(title: "test3", isCompleted: true),
            TaskItem(title: "test4", isCompleted: false)
        ]
        
        let group = TaskGroup(title: "Group Test", symbolName: "house.fill", tasks: tasks) // tasks of type tasks from above array of tasks.
        
        // ACT: Calculating the logic (look at view)
        let completedCount = group.tasks.filter{$0.isCompleted}.count
        let progress = Double(completedCount) / Double(group.tasks.count)
        
        // ASSERT: What is the final output of logic expected
        XCTAssertEqual(progress, 0.5, "Progress should be 50% when half the tasks are completed")
    }
}
