//
//  SignUpValidatorTests.swift
//  FormsAndNavigation-DojoTests
//
//  Created by Gabriel Pereira on 22/03/22.
//

import XCTest
@testable import FormsAndNavigation_Dojo

final class SignUpValidatorTests: XCTestCase {
    // MARK: - Properties
    private let sut: SignUpValidatorProtocol = SignUpValidator()
    
    // MARK: - Test Methods
    func test_getValidEmail_whenEmailParameterIsNil_shouldReturnFalse() {
        let assertObject = sut.getValidEmail(email: nil)
        
        XCTAssertFalse(assertObject.valid)
        XCTAssertTrue(assertObject.value.isEmpty)
    }
    
    func test_getValidEmail_whenEmailParameterHasSpaceBetweenWords_shouldReturnFalse() {
        let dummyValue: String = "dummy dummy@dummy.com"
        let assertObject = sut.getValidEmail(email: dummyValue)
        
        XCTAssertFalse(assertObject.valid)
        XCTAssertEqual(assertObject.value, dummyValue)
    }
    
    func test_getValidEmail_whenEmailHasInvalidCharacters_shouldReturnFalse() {
        // TODO - Começar o DOJO de amanhã aqui
        let dummyValue: String = "dummy&@dummy.com"
        let assertObject = sut.getValidEmail(email: dummyValue)
        
        XCTAssertFalse(assertObject.valid)
        XCTAssertEqual(assertObject.value, dummyValue)
    }
    
    
    
    func test_getValidEmail_whenEmailParameterIsValid_shouldReturnTrue() {
        let dummyValue: String = "dummy@dummy.com"
        let assertObject = sut.getValidEmail(email: dummyValue)
        
        XCTAssertTrue(assertObject.valid)
        XCTAssertEqual(assertObject.value, dummyValue)
    }
}
