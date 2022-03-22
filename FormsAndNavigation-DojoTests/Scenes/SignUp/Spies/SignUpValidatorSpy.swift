//
//  SignUpValidatorSpy.swift
//  FormsAndNavigation-DojoTests
//
//  Created by Gabriel Pereira on 18/03/22.
//

import XCTest
@testable import FormsAndNavigation_Dojo

final class SignUpValidatorSpy: SignUpValidatorProtocol {
    // MARK: - Properties
    private var verifyGetValidFirstName: [String?] = []
    private var verifyGetValidEmail: [String?] = []
    private var verifyGetValidPassword: [String?] = []
    
    private let validator: SignUpValidator = .init()
    
    // MARK: - SignUpValidatorProtocol Methods
    func getValidFirstName(name: String?) -> (valid: Bool, value: String) {
        verifyGetValidFirstName.append(name)
        
        return validator.getValidFirstName(name: name)
    }
    
    func getValidEmail(email: String?) -> (valid: Bool, value: String) {
        verifyGetValidEmail.append(email)
        
        return validator.getValidEmail(email: email)
    }
    
    func getValidPassword(password: String?) -> (valid: Bool, value: String) {
        verifyGetValidPassword.append(password)
        
        return validator.getValidPassword(password: password)
    }
}

// MARK: - Verifier Methods
extension SignUpValidatorSpy {
    func verifyGetValidFirstNameWasCalledOnce(
        argument: String?,
        file: StaticString = #file,
        line: UInt = #line
    ) {
        guard verifyGetValidFirstName.count == 1 else {
            XCTFail(
                "Wanted 1 but was called \(verifyGetValidFirstName.count) times. SignUpValidator.getValidFirstName(name:) method with args: \(verifyGetValidFirstName.description)",
                file: file,
                line: line
            )
            
            return
        }
    }
}
