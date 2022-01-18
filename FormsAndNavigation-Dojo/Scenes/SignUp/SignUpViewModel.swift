//
//  SignUpViewModel.swift
//  FormsAndNavigation-Dojo
//
//  Created by Rafael Ramos on 18/01/22.
//

import Foundation

protocol SignUpViewModelProtocol {
    var title: String { get }
    var inputFirstName: String { get }
    var inputLastName: String { get }
    var inputAge: String { get }
    var inputEmail: String { get }
    var inputPassword: String { get }
    var signUpButton: String { get }
    var analyticsSignUpSuccess: String { get }
    var analyticsSignUpFailed: String { get }
    var analyticsSignUpError: String { get }
}

final class SignUpViewModel: SignUpViewModelProtocol {
    let title: String = "SignUp"
    let inputFirstName: String = "inputFirstName"
    let inputLastName: String = "inputLastName"
    let inputAge: String = "inputAge"
    let inputEmail: String = "inputEmail"
    let inputPassword: String = "inputPassword"
    let signUpButton: String = "Cadastrar"
    let analyticsSignUpSuccess: String = Constants.SignUpStrings.analyticsSignUpSuccess
    let analyticsSignUpFailed: String = "SignUp-Failed"
    let analyticsSignUpError: String = "SignUp-Error"
}
