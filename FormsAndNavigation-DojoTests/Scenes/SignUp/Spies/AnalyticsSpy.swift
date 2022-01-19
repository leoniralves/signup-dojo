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
}

