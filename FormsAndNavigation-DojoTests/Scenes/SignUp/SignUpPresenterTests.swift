//
//  SignUpPresenterTests.swift
//  FormsAndNavigation-DojoTests
//
//  Created by Leonir Deolindo on 18/01/22.
//

import XCTest
@testable import FormsAndNavigation_Dojo

final class SignUpPresenterTests: XCTestCase {
    
    private var analyticsSpy: AnalyticsSpy = .init()

    private lazy var sut: SignUpPresenter = {
        return .init(analytics: analyticsSpy)
    }()
    
    func test_trackNetworkRequest_withResultSuccess_andDataTrue_shouldSendSingUpSuccess() {
        sut.trackNetworkRequest(result: .success(true))

        XCTAssertEqual(analyticsSpy.sendArgs.count, 1)
        XCTAssertEqual(analyticsSpy.sendArgs.first, "batatinha")
    }
}

final class AnalyticsSpy: AnalyticsProtocol {
    private(set) var sendArgs: [String] = []

    func configuration() {
        
    }
    
    func send(_ event: String) {
        sendArgs.append(event)
    }
}
