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
        
        guard isValidUserData(
            nameValid: nameVerified.valid,
            emailValid: emailVerified.valid,
            passwordValid: passwordVerified.valid
        ) else {
            return
        }
        
        requestSignUp(
            firstName: nameVerified.value,
            lastName: user.lastName,
            age: user.age,
            email: emailVerified.value,
            password: passwordVerified.value
        )
    }
    
    private func isValidUserData(nameValid: Bool, emailValid: Bool, passwordValid: Bool) -> Bool {
        var outputsError: [Bool] = []

        if !nameValid {
            output?.textFieldInputError(for: .name)
            outputsError.append(false)
        }

        if !emailValid {
            output?.textFieldInputError(for: .email)
            outputsError.append(false)
        }

        if !passwordValid {
            output?.textFieldInputError(for: .password)
            outputsError.append(false)
        }
        
        return outputsError.count == 0
    }
    
    private func requestSignUp(firstName: String, lastName: String?, age: String?, email: String, password: String) {
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
