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
    func textFieldInputError(for fieldTypes: [FieldTypeError])
}

//enum FieldTypeError: String {
//    case name = "O nome deve ter entre 10 e 30 caracteres"
//    case email = "email regras"
//    case password = "password regras"
//}

enum FieldTypeError: Error {
    case name
    case email
    case password
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
//    func userDidRequestToSignUp(user: SignUpModel) {
//        // Validar dados
//        // Se deu errado, dispara delegate
//        // Se deu certo, faz request
//        // Callback
//    }
    
    func userDidRequestToSignUp(user: SignUpModel) {
        let errors = handleUserData(user: user)
        
        guard isValidUserData(errors.1) else {
            return
        }
        
//        requestSignUp(
//            firstName: nameVerified.value,
//            lastName: user.lastName,
//            age: user.age,
//            email: emailVerified.value,
//            password: passwordVerified.value
//        )
    }
    
    private func handleUserData(user: SignUpModel) -> (user: SignUpModel, errors: [FieldTypeError]?) {
        let nameVerified: (valid: Bool, value: String) = validator.getValidFirstName(name: user.firstName)
        let emailVerified: (valid: Bool, value: String) = validator.getValidEmail(email: user.email)
        let passwordVerified: (valid: Bool, value: String) = validator.getValidPassword(password: user.password)
        
        var outputsError: [FieldTypeError] = []

        if !nameVerified.valid {
            outputsError.append(.name)
        }

        if !emailVerified.valid {
            outputsError.append(.email)
        }

        if !passwordVerified.valid {
            outputsError.append(.password)
        }
        
        return (adapter(user: <#T##SignUpModel#>), outputsError)
    }

    private func isValidUserData(_ fieldTypeErrors: [FieldTypeError]) -> Bool {
        if !fieldTypeErrors.isEmpty {
            output?.textFieldInputError(for: fieldTypeErrors)
            return false
        }

        return true
    }
    
    func adapter(user: SignUpModel) -> UserDataDTO {
        return .init(
            firstName: nameVerified.value,
            lastName: user.lastName,
            age: user.age,
            email: emailVerified.value,
            password: passwordVerified.value
        )
    }
    
    private func requestSignUp(user: SignUpModel) {
        networker.request(target: .signUp(
            firstName: firstName,
            lastName: lastName,
            age: age,
            email: email,
            password: password
        )) { result in
            trackNetworkRequest(result: result)
        }
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
