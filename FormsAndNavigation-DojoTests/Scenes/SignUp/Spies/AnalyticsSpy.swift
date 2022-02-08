//
//  AnalyticsSpy.swift
//  FormsAndNavigation-DojoTests
//
//  Created by Kauê Sales on 19/01/22.
//

import XCTest
@testable import FormsAndNavigation_Dojo

final class AnalyticsSpy: AnalyticsProtocol {
    private(set) var sendArgs: [String] = []
    
    func configuration() {
        XCTFail("Spy not implemented")
    }
    
    func send(_ event: String) {
        sendArgs.append(event)
    }
    
    func sendVerifyArgs(
        event: String,
        file: StaticString = #file,
        line: UInt = #line
    ) {
        XCTAssertEqual(
            sendArgs.count,
            1,
            file: file,
            line: line
        )
        
        XCTAssertEqual(
            sendArgs.first,
            "SignUp-\(event)",
            file: file,
            line: line
        )
    }
    
    func sendNeverCalled(
        file: StaticString = #file,
        line: UInt = #line
    ) {
        XCTAssertEqual(
            sendArgs.count,
            0,
            file: file,
            line: line
        )
    }
}

