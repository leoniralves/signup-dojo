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
    func trackNetworkRequest(result: Result<Bool, Error>)
}

final class SignUpViewModel: SignUpViewModelProtocol {
    // MARK: - Properties
    private let analyticsSignUp: String = "SignUp-"
    private var analytics: AnalyticsProtocol
    
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
    
    // MARK: - Initializer Methods
    init(
        analytics: AnalyticsProtocol = Analytics.shared
    ) {
        self.analytics = analytics
    }
    
    // MARK: - Public and Internal Methods
    func trackNetworkRequest(result: Result<Bool, Error>) {
        switch result {
        case .success(let success):
            
        case .failure(let error):
        }
    }
    
    // MARK: - Private Methods
    private func trackNetworkRequestSuccess(
        success: Bool,
        error: Error?
    ) {
        var requestState: String = "Error"
        
        if let success = success {
            requestState = success ? "Success" : "Failed"
        }
        
        analytics.send(analyticsSignUp + requestState)
    }
}
