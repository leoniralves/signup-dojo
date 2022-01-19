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
    
    func test_trackNetworkRequest_whenResultSuccess_andDataTrue_shouldSendSignUpSuccess() {
        sut.trackNetworkRequest(result: .success(true))
        

        XCTAssertEqual(analyticsSpy.sendArgs.count, 1)
        XCTAssertEqual(analyticsSpy.sendArgs.first, "SignUp-Success")
    }
    
    func test_trackNetworkRequest_whenResultSuccess_andDataFalse_shouldSendSignUpFailed() {
        sut.trackNetworkRequest(result: .success(false))
        

        XCTAssertEqual(analyticsSpy.sendArgs.count, 1)
        XCTAssertEqual(analyticsSpy.sendArgs.first, "SignUp-Failed")
    }
    
    func test_trackNetworkRequest_whenResultFailure_andHasError_shouldSendSignUpFailed() {
        
    }
}
