//
//  Tests_macOS.swift
//  Tests macOS
//
//  Created by Katelyn Lydeen on 2/2/22.
//

import XCTest

class Tests_macOS: XCTestCase {

    override func setUpWithError() throws {
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

    func testFirstBessel() {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
        
        let xValue = Double.pi
        var testValue = 0.0
        let exactValue = 0.0
        
        testValue = calculateFirstSphericalBessel(xValue: xValue)
        
        XCTAssertEqual(testValue, exactValue, accuracy: 1.0e-8, "Was not equal to the specified resolution.")
    }

    func testSecondBessel() {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
        
        let xValue = 4.493409457909064175308
        var testValue = 0.0
        let exactValue = 0.0
        
        testValue = calculateSecondSphericalBessel(xValue: xValue)
        
        XCTAssertEqual(testValue, exactValue, accuracy: 1.0e-8, "Was not equal to the specified resolution.")
    }
    
    func testSphericalBessel() {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
        
        let xValue = 10.0
        var testValue = 0.0
        
        let testOrder = 12          // order of Bessel function
        var start = testOrder+25    // used for downward recursion
        
        let exactValue = 0.01721599974499280605513
        testValue = calculateDownwardRecursion(xValue: xValue, order: testOrder, start: start)
        
        
        XCTAssertEqual(testValue, exactValue, accuracy: 1.0e-10, "Was not equal to the specified resolution.")
        
        // Test the quality of the values computed by the downward recursion
        // We want the relative error to be less than 10e-10
        // We'll use small x because smaller values lead to more issues with error
        let x = 0.1
        let orderList = [3, 5, 8]
        let correctValues = [9.518519719e-6, 9.616310231e-10, 2.901200102e-16]
        var error:Double
        for (index, order) in orderList.enumerated() {
            start = order+25
            testValue = calculateDownwardRecursion(xValue: x, order: order, start: start)
            error = abs(testValue - correctValues[index]) / correctValues[index]
            if (error > 5.0e-10) {
                XCTFail("Error at order \(order) was greater than the specified value.")
            }
        }
        
    }
    
    func testLaunchPerformance() throws {
        if #available(macOS 10.15, iOS 13.0, tvOS 13.0, watchOS 7.0, *) {
            // This measures how long it takes to launch your application.
            measure(metrics: [XCTApplicationLaunchMetric()]) {
                XCUIApplication().launch()
            }
        }
    }
}
