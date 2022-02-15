//
//  SignUpPresenterOutputSpy.swift
//  FormsAndNavigation-DojoTests
//
//  Created by Rafael Ramos on 11/02/22.
//

import Foundation
@testable import FormsAndNavigation_Dojo
import XCTest

final class SignUpPresenterOutputSpy: SignUpPresenterOutput {
    // MARK: - Properties
    var textFieldInputErrorArgs: [FieldTypeError] = []
    
    // MARK: - SignUpPresenterOutput Methods
    func textFieldInputError(for fieldType: FieldTypeError) {
        textFieldInputErrorArgs.append(fieldType)
    }
    
    // TODO: - Começar por aqui escrevendo os métodos de verificação de chamadas do método `textFieldInputError`
    func verifyTextFieldInputErrorWasCalledOnce(
        error: FieldTypeError,
        file: StaticString = #file,
        line: UInt = #line
    ) {
        guard textFieldInputErrorArgs.count == 1 else {
            XCTFail("Method textFieldInputError expected once, but was called \(textFieldInputErrorArgs.count)")
            return
        }
        
        XCTAssertEqual(
            error,
            textFieldInputErrorArgs.first,
            file: file,
            line: line
        )
        
        XCTAssertEqual(
            error.rawValue,
            textFieldInputErrorArgs.first?.rawValue,
            file: file,
            line: line
        )
    }
    
    func verifyTextFieldInputErrorWasNeverCalled(
        error: FieldTypeError,
        file: StaticString = #file,
        line: UInt = #line
    ) {
        guard textFieldInputErrorArgs.count == 0 else {
            XCTFail("Method textFieldInputError expected 0, but was called \(textFieldInputErrorArgs.count)")
            return
        }
        
        // TODO: Finish this neverCalled assertions
        XCTAssertEqual(
            error,
            textFieldInputErrorArgs.first,
            file: file,
            line: line
        )
        
        XCTAssertEqual(
            error.rawValue,
            textFieldInputErrorArgs.first?.rawValue,
            file: file,
            line: line
        )
    }
}
