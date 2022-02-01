//
//  SignUpPresenterTests.swift
//  FormsAndNavigation-DojoTests
//
//  Created by Leonir Deolindo on 18/01/22.
//

import XCTest
@testable import FormsAndNavigation_Dojo

final class SignUpPresenterTests: XCTestCase {
    // MARK: - Properties
    private let analyticsSpy: AnalyticsSpy = .init()
    private let networkerSpy: NetworkerSpy = .init()

    private lazy var sut: SignUpPresenter = {
        return .init(
            networker: networkerSpy,
            analytics: analyticsSpy
        )
    }()
    
    // MARK: - Test Methods
//    func test_trackNetworkRequest_whenResultSuccess_andDataTrue_shouldSendSignUpSuccess() {
//        sut.trackNetworkRequest(result: .success(true))
//
//        thenAssertAnalyticsWasCalledOnce(event: "Success")
//    }
//
//    func test_trackNetworkRequest_whenResultSuccess_andDataFalse_shouldSendSignUpFailed() {
//        sut.trackNetworkRequest(result: .success(false))
//
//        thenAssertAnalyticsWasCalledOnce(event: "Failed")
//    }
//
//    func test_trackNetworkRequest_whenResultFailure_andHasError_shouldSendSignUpFailed() {
//        sut.trackNetworkRequest(result: .failure(DummyError.dummy))
//
//        thenAssertAnalyticsWasCalledOnce(event: "Error")
//    }
    
    func test_zero() {
        sut.userDidRequestToSignUp(user: .make())
        thenAssertAnalyticsWasCalledOnce(event: "Success")
    }
}

extension SignUpModel {
    static func make(
        firstName: String? = nil,
        lastName: String? = nil,
        age: String? = nil,
        email: String? = nil,
        password: String? = nil
    ) -> Self {
        .init(
            firstName: firstName,
            lastName: lastName,
            age: age,
            email: email,
            password: password
        )
    }
}

// MARK: - Mock
extension SignUpPresenterTests {
    enum DummyError: Error {
        case dummy
    }
}

// MARK: - Assertion Methods
extension SignUpPresenterTests {
    func thenAssertAnalyticsWasCalledOnce(
        event: String,
        file: StaticString = #file,
        line: UInt = #line
    ) {
        XCTAssertEqual(
            analyticsSpy.sendArgs.count,
            1,
            file: file,
            line: line
        )
        
        XCTAssertEqual(
            analyticsSpy.sendArgs.first,
            "SignUp-\(event)",
            file: file,
            line: line
        )
    }
}
