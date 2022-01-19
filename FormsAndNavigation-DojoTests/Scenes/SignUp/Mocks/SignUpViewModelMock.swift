//
//  SignUpViewModelMock.swift
//  FormsAndNavigation-DojoTests
//
//  Created by Rafael Ramos on 14/01/22.
//

import Foundation
@testable import FormsAndNavigation_Dojo

final class SignUpViewModelMock: SignUpViewModelProtocol {
    var title: String = "dummyTitle"
    
    var inputFirstName: String = "dummyInputFirstName"
    
    var inputLastName: String = "dummyInputLastName"
    
    var inputAge: String = "dummyInputAge"
    
    var inputEmail: String = "dummyInputEmail"
    
    var inputPassword: String = "dummyInputPassword"
    
    var signUpButton: String = "dummySignUpButton"
}
