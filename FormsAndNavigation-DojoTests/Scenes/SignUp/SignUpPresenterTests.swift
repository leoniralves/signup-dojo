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
    private let outputSpy: SignUpPresenterOutputSpy = .init()
    
    // MARK: - Computed Properties
    private lazy var sut: SignUpPresenter = {
        let presenter: SignUpPresenter = .init(
            networker: networkerSpy,
            analytics: analyticsSpy
        )
        
        presenter.setOutput(output: outputSpy)
        
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
        
        outputSpy.verifyTextFieldInputErrorWasCalledOnce(error: .name)
        thenAssertAnalyticsWasNeverCalled()
    }
    
    func test_userDidRequestToSignUp_whenUserDataFirstNameIsLessThan10_shouldCallOutputTextFieldErrorWithNameFieldType() {
        let dummyFirstName: String = givenStringOfSize(9)
        sut.userDidRequestToSignUp(user: .make(firstName: dummyFirstName))
        
        outputSpy.verifyTextFieldInputErrorWasCalledOnce(error: .name)
        thenAssertAnalyticsWasNeverCalled()
    }
    
    func test_userDidRequestToSignUp_whenUserDataFirstNameIsGreatherThan30_shouldCallOutputTextFieldErrorWithNameFieldType() {
        let dummyFirstName: String = givenStringOfSize(31)
        sut.userDidRequestToSignUp(user: .make(firstName: dummyFirstName))
        
        outputSpy.verifyTextFieldInputErrorWasCalledOnce(error: .name)
    }
    
    func test_userDidRequestToSignUp_whenUserDataFirstNameIsGreatherThan30_shouldNeverCallAnalytics() {
        let dummyFirstName: String = givenStringOfSize(31)
        sut.userDidRequestToSignUp(user: .make(firstName: dummyFirstName))
        
        thenAssertAnalyticsWasNeverCalled()
    }
    
    func test_userDidRequestToSignUp_whenUserDataFirstNameIsGreatherThanOrEqual10AndLessThanOrEqual30_shouldNotCallOutputTextFieldErrorWithNameFieldType_() {
        let dummyFirstName: String = givenStringOfSize(10)
        sut.userDidRequestToSignUp(user: .make(firstName: dummyFirstName))
        
        outputSpy.verifyTextFieldInputErrorWasNeverCalled()
    }
    
    func test_userDidRequestToSignUp_whenUserDataFirstNameIsGreatherThanOrEqual10AndLessThanOrEqual30_() {
        let dummyFirstName: String = givenStringOfSize(10)
        let dummyModel: SignUpModel = .make(
            firstName: dummyFirstName,
            lastName: nil,
            age: nil,
            email: "dummy",
            password: "dummyPassword"
        )
        
        sut.userDidRequestToSignUp(user: dummyModel)
        
        networkerSpy.verifyRequestArg(
            arg: .signUp(
                firstName: dummyModel.firstName!,
                lastName: dummyModel.lastName,
                age: dummyModel.age,
                email: dummyModel.email!,
                password: dummyModel.password!
            )
        )
    }
    
    private func givenStringOfSize(_ count: Int) -> String {
        return (0..<count)
            .map { _ in "a" }
            .joined()
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
