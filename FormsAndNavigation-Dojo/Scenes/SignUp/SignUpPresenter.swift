//
//  SignUpPresenter.swift
//  FormsAndNavigation-Dojo
//
//  Created by Leonir Deolindo on 18/01/22.
//

import Foundation
import UIKit

protocol SignUpPresenterInput {
    func userDidRequestToSignUp(user: SignUpModel)
}

protocol SignUpPresenterOutput: AnyObject {
    func textFieldInputError(for fieldType: FieldTypeError)
}

enum FieldTypeError: String {
    case name = "O nome deve ter entre 10 e 30 caracteres"
    case email = "email regras"
    case password = "password regras"
}

final class SignUpPresenter: SignUpPresenterInput {
    // MARK: - Properties
    private var analytics: AnalyticsProtocol
    private let networker: NetworkerProtocol
    private let validator: SignUpValidatorProtocol
    private weak var output: SignUpPresenterOutput?
    
    // MARK: - Initializer Methods
    init(
        networker: NetworkerProtocol = Networker(),
        analytics: AnalyticsProtocol = Analytics.shared,
        validator: SignUpValidatorProtocol = SignUpValidator()
    ) {
        self.networker = networker
        self.analytics = analytics
        self.validator = validator
    }

    func setOutput(output: SignUpPresenterOutput?) {
        self.output = output
    }
    
    // MARK: - Public and Internal Methods
    func userDidRequestToSignUp(user: SignUpModel) {
        let nameVerified: (valid: Bool, value: String) = validator.getValidFirstName(name: user.firstName)
        let emailVerified: (valid: Bool, value: String) = validator.getValidEmail(email: user.email)
        let passwordVerified: (valid: Bool, value: String) = validator.getValidPassword(password: user.password)
        
        guard nameVerified.valid else {
            output?.textFieldInputError(for: .name)
            return
        }

        guard emailVerified.valid else {
            output?.textFieldInputError(for: .email)
            return
        }

        guard passwordVerified.valid else {
            output?.textFieldInputError(for: .password)
            return
        }
        
        networker.request(target: .signUp(
            firstName: nameVerified.value,
            lastName: user.lastName,
            age: user.age,
            email: user.email ?? "Xablau",
            password: user.password ?? "Xablau"
        )) { result in
            trackNetworkRequest(result: result)
        }
    }
    
    private func verifyUserData(user: SignUpModel) -> Bool {
        guard verifyUserFirstName(name: user.firstName) else {
            return false
        }
        
        return true
    }
    
    private func verifyUserFirstName(isValid: Bool, type: FieldTypeError) {
        guard isValid else {
            //TODO: Criar funções de output de erro ✅ e testar cenário
            output?.textFieldInputError(for: type)
        }

        return isValid
    }
    
    
    private func trackNetworkRequest(result: Result<Bool, Error>) {
        switch result {
        case .success(let success):
            trackNetworkRequest(success: success, error: nil)
        case .failure(let error):
            trackNetworkRequest(success: false, error: error)
        }
    }
    
    // MARK: - Private Methods
    private func trackNetworkRequest(
        success: Bool,
        error: Error?
    ) {
        let errorState: String = error != nil ? "Error" : "Failed"
        let requestState: String = success ? "Success" : errorState
        
        analytics.send("SignUp-\(requestState)")
    }
}
