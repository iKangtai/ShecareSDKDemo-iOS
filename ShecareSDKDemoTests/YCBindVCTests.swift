//
//  YCBindVCTests.swift
//  ShecareSDKTests
//
//  Created by 罗培克 on 2018/3/15.
//  Copyright © 2018年 ikangtai.com. All rights reserved.
//

import XCTest
@testable import ShecareSDKDemo
import ShecareSDK

class YCBindVCTests: XCTestCase {
    
    override func setUp() {
        super.setUp()
        
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func testBindViewShow() {
        let bindVC = ShecareService.bindViewController()
        RunLoop.main.run(until: Date(timeIntervalSinceNow: TimeInterval(3)))
        UIViewController.currentViewController().show(bindVC, sender: nil)
        RunLoop.main.run(until: Date(timeIntervalSinceNow: TimeInterval(3)))
    }
    
    func testPerformanceExample() {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }
    
}
