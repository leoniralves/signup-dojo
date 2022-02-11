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
    private let signUpPresenterSpy: SignUpPresenterOutputSpy = .init()

    // MARK: - Computed Properties
    private lazy var sut: SignUpPresenter = {
        let presenter: SignUpPresenter = .init(
            networker: networkerSpy,
            analytics: analyticsSpy
        )
        
        presenter.setOutput(output: signUpPresenterSpy)
        
        return presenter
    }()
    
    // MARK: - Test Methods
    func test_userDidRequestToSignUp_whenAllParametersAreNil_shouldNotCallAnalyticsSend() {
        sut.userDidRequestToSignUp(user: .make())
        
        thenAssertAnalyticsWasNeverCalled()
    }

    func test_userDidRequestToSignUp_whenGetFirstNameEmailPasswordNotEmpty_shouldNotCallAnalyticsSend() {
        sut.userDidRequestToSignUp(user: .make())
        
        thenAssertAnalyticsWasNeverCalled()
    }
    
    func test_userDidRequestToSignUp_whenUserDataFirstNameIsNil_shouldCallOutputTextFieldErrorWithNameFieldType() {
        sut.userDidRequestToSignUp(user: .make())
        
        
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
        analyticsSpy.sendVerifyArgs(
            event: event,
            file: file,
            line: line
        )
    }

    func thenAssertAnalyticsWasNeverCalled(
        file: StaticString = #file,
        line: UInt = #line
    ) {
        analyticsSpy.sendNeverCalled(
            file: file,
            line: line
        )
    }
}
