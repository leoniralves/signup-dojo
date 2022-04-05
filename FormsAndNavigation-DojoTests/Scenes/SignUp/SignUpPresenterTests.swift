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
    private let signUpValidatorSpy: SignUpValidatorSpy = .init()
    
    private  let dummyFirstName: String = "dummyFirstName"
    private  let dummyEmail: String = "dummyEmail@dummyEmail.com"
    private  let dummyPassword: String = "dummyPassword"
    
    // MARK: - Computed Properties
    private lazy var sut: SignUpPresenter = {
        let presenter: SignUpPresenter = .init(
            networker: networkerSpy,
            analytics: analyticsSpy,
            validator: signUpValidatorSpy
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
        sut.userDidRequestToSignUp(user: .make(email: dummyEmail, password: dummyPassword))
        
        outputSpy.verifyTextFieldInputErrorWasCalledOnce(errors: [.name])
        thenAssertAnalyticsWasNeverCalled()
    }
    
    func test_userDidRequestToSignUp_whenUserDataFirstNameIsLessThan10_shouldCallOutputTextFieldErrorWithNameFieldType() {
        let dummyFirstName: String = givenStringOfSize(9)
        sut.userDidRequestToSignUp(user: .make(firstName: dummyFirstName, email: dummyEmail))
        
        outputSpy.verifyTextFieldInputErrorWasCalledOnce(errors: [.name])
        thenAssertAnalyticsWasNeverCalled()
    }
    
    func test_userDidRequestToSignUp_whenUserDataFirstNameIsGreatherThan30_shouldCallOutputTextFieldErrorWithNameFieldType() {
        let dummyFirstName: String = givenStringOfSize(31)
        sut.userDidRequestToSignUp(user: .make(
            firstName: dummyFirstName,
            email: dummyEmail
        ))
        
        outputSpy.verifyTextFieldInputErrorWasCalledOnce(errors: [.name])
    }
    
    func test_userDidRequestToSignUp_whenUserDataFirstNameIsGreatherThan30_shouldNeverCallAnalytics() {
        let dummyFirstName: String = givenStringOfSize(31)
        sut.userDidRequestToSignUp(user: .make(firstName: dummyFirstName, email: dummyEmail))
        
        thenAssertAnalyticsWasNeverCalled()
    }
    
    func test_userDidRequestToSignUp_whenUserDataFirstNameIsGreatherThanOrEqual10AndLessThanOrEqual30_shouldNotCallOutputTextFieldErrorWithNameFieldType_() {
        sut.userDidRequestToSignUp(user: .make(firstName: dummyFirstName, email: dummyEmail, password: dummyPassword))
        
        signUpValidatorSpy.verifyGetValidFirstNameWasCalledOnce(argument: dummyFirstName)
        outputSpy.verifyTextFieldInputErrorWasNeverCalled()
    }
    
    func test_userDidRequestToSignUp_whenUserDataFirstNameIsGreatherThanOrEqual10AndLessThanOrEqual30_() {
        let dummyFirstName: String = givenStringOfSize(10)
        let dummyModel: SignUpModel = .make(
            firstName: dummyFirstName,
            lastName: nil,
            age: nil,
            email: dummyEmail,
            password: dummyPassword
        )
        
        sut.userDidRequestToSignUp(user: dummyModel)
        
        networkerSpy.verifyRequestArg(
            arg: .signUp(
                firstName: dummyModel.firstName,
                lastName: dummyModel.lastName,
                age: dummyModel.age,
                email: dummyModel.email,
                password: dummyModel.password
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
