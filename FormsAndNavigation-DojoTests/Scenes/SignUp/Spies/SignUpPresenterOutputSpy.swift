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
    var textFieldInputErrorArgs: [[FieldTypeError]] = []
    
    // MARK: - SignUpPresenterOutput Methods
    func textFieldInputError(for fieldTypes: [FieldTypeError]) {
        textFieldInputErrorArgs.append(fieldTypes)
    }
    
    // TODO: - Começar por aqui escrevendo os métodos de verificação de chamadas do método `textFieldInputError`
    func verifyTextFieldInputErrorWasCalledOnce(
        errors: [FieldTypeError],
        file: StaticString = #file,
        line: UInt = #line
    ) {
        guard textFieldInputErrorArgs.count == 1 else {
            XCTFail(
                "Method textFieldInputError expected once, but was called \(textFieldInputErrorArgs.count) with args \(textFieldInputErrorArgs)",
                file: file,
                line: line
            )
            return
        }
        
        XCTAssertEqual(
            errors,
            textFieldInputErrorArgs.first,
            file: file,
            line: line
        )
        
        XCTAssertEqual(
            errors,
            textFieldInputErrorArgs.first,
            file: file,
            line: line
        )
    }
    
    func verifyTextFieldInputErrorWasNeverCalled(
        file: StaticString = #file,
        line: UInt = #line
    ) {
        XCTAssertEqual(
            textFieldInputErrorArgs.count,
            0,
            "Method textFieldInputError expected 0, but was called \(textFieldInputErrorArgs.count)",
            file: file,
            line: line
        )
    }
}
