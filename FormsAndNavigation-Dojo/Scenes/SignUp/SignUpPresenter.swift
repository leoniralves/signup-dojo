//
//  SignUpPresenter.swift
//  FormsAndNavigation-Dojo
//
//  Created by Leonir Deolindo on 18/01/22.
//

import Foundation

protocol SignUpPresenterInput {
    func userDidRequestToSignUp(user: SignUpModel)
}

protocol SignUpPresenterOutput {
    
}

final class SignUpPresenter: SignUpPresenterInput {
    // MARK: - Properties
    private var analytics: AnalyticsProtocol
    private let networker: NetworkerProtocol
    
    // MARK: - Initializer Methods
    init(
        networker: NetworkerProtocol = Networker(),
        analytics: AnalyticsProtocol = Analytics.shared
    ) {
        self.networker = networker
        self.analytics = analytics
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
    
    private func verifyUserFirstName(name: String?) -> Bool {
        guard let firstName = name else {
            //TODO: Criar funções de output de erro e testar cenário
            return false
        }

        
        return firstName.count >= 10 && firstName.count <= 30
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
