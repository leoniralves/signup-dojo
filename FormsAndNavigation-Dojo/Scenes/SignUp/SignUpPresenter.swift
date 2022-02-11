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
}

final class SignUpPresenter: SignUpPresenterInput {
    // MARK: - Properties
    private var analytics: AnalyticsProtocol
    private let networker: NetworkerProtocol
    private weak var output: SignUpPresenterOutput?
    
    // MARK: - Initializer Methods
    init(
        networker: NetworkerProtocol = Networker(),
        analytics: AnalyticsProtocol = Analytics.shared
    ) {
        self.networker = networker
        self.analytics = analytics
    }

    func setOutput(output: SignUpPresenterOutput?) {
        self.output = output
    }
    
    // MARK: - Public and Internal Methods
    func userDidRequestToSignUp(user: SignUpModel) {
        
        guard let firstName = user.firstName,
              let email = user.email,
              let password = user.password
        else {
            return
        }
        
        networker.request(target: .signUp(
            firstName: firstName,
            lastName: user.lastName,
            age: user.age,
            email: email,
            password: password
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
    
    func verifyUserFirstName(name: String?) -> Bool {
        guard let firstName = name, firstName.count >= 10 && firstName.count <= 30  else {
            //TODO: Criar funções de output de erro ✅ e testar cenário
            output?.textFieldInputError(for: .name)
            return false
        }

        return true
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
