//
//  SignUpPresenter.swift
//  FormsAndNavigation-Dojo
//
//  Created by Leonir Deolindo on 18/01/22.
//

import Foundation

protocol SignUpPresenterProtocol {
    func trackNetworkRequest(result: Result<Bool, Error>)
}

final class SignUpPresenter: SignUpPresenterProtocol {
    // MARK: - Properties
    private var analytics: AnalyticsProtocol
    
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
