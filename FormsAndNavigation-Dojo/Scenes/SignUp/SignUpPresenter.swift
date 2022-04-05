//
//  SignUpPresenter.swift
//  FormsAndNavigation-Dojo
//
//  Created by Leonir Deolindo on 18/01/22.
//

import Foundation
import UIKit

protocol SignUpPresenterInput {
    func userDidRequestToSignUp(user: SignUpDTO)
}

protocol SignUpPresenterOutput: AnyObject {
    func textFieldInputError(for fieldTypes: [FieldTypeError])
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
    func userDidRequestToSignUp(user: SignUpDTO) {
        let state = handleUserData(user: user)

        switch state {
        case .success(let user):
            requestSignUp(user: user)
        case .failure(let formError):
            output?.textFieldInputError(for: formError.errors)
        }
    }
    
    private func handleUserData(user: SignUpDTO) -> Result<SignUpModel, SignUpFormErrors> {
        let nameVerified: (valid: Bool, value: String) = validator.getValidFirstName(name: user.firstName)
        let emailVerified: (valid: Bool, value: String) = validator.getValidEmail(email: user.email)
        let passwordVerified: (valid: Bool, value: String) = validator.getValidPassword(password: user.password)
        
        var formErrors: SignUpFormErrors = .init(errors: [])
        
        if !nameVerified.valid {
            formErrors.errors.append(.name)
        }
        
        if !emailVerified.valid {
            formErrors.errors.append(.email)
        }
        
        if !passwordVerified.valid {
            formErrors.errors.append(.password)
        }
        
        if formErrors.errors.isEmpty {
            return .success(.init(
                firstName: nameVerified.value,
                lastName: user.lastName,
                age: user.age,
                email: emailVerified.value,
                password: passwordVerified.value))
        } else {
            return .failure(formErrors)
        }
    }
    
    private func isValidUserData(_ fieldTypeErrors: [FieldTypeError]) -> Bool {
        if !fieldTypeErrors.isEmpty {
            output?.textFieldInputError(for: fieldTypeErrors)
            return false
        }
        
        return true
    }
    
    private func requestSignUp(user: SignUpModel) {
        networker.request(target: .signUp(
            firstName: user.firstName,
            lastName: user.lastName,
            age: user.age,
            email: user.email,
            password: user.password
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
