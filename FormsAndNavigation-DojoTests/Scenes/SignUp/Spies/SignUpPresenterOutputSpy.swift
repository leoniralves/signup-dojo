//
//  SignUpPresenterOutputSpy.swift
//  FormsAndNavigation-DojoTests
//
//  Created by Rafael Ramos on 11/02/22.
//

import Foundation
@testable import FormsAndNavigation_Dojo

final class SignUpPresenterOutputSpy: SignUpPresenterOutput {
    // MARK: - Properties
    var textFieldInputErrorArgs: [FieldTypeError] = []
    
    // MARK: - SignUpPresenterOutput Methods
    func textFieldInputError(for fieldType: FieldTypeError) {
        textFieldInputErrorArgs.append(fieldType)
    }
    
    // TODO: - Começar por aqui escrevendo os métodos de verificação de chamadas do método `textFieldInputError`
}
