//
//  SignUpPresenterOutputSpy.swift
//  FormsAndNavigation-DojoTests
//
//  Created by Rafael Ramos on 11/02/22.
//

import Foundation
@testable import FormsAndNavigation_Dojo

final class SignUpPresenterOutputSpy: SignUpPresenterOutput {
    
    var textFieldInputError: [FieldTypeError] = []
    
    func textFieldInputError(for fieldType: FieldTypeError) {
        
    }
}
