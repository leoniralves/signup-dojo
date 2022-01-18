//
//  SignUpPresenter.swift
//  FormsAndNavigation-Dojo
//
//  Created by Leonir Deolindo on 18/01/22.
//

import Foundation

protocol SingUpPresenterProtocol {
    func trackNetworkRequest(result: Result<Bool, Error>)
}

final class SignUpPresenter: SingUpPresenterProtocol {
    
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
            trackNetworkRequestSuccess(success: success, error: nil)
        case .failure(let error):
            trackNetworkRequestSuccess(success: false, error: error)
        }
    }
    
    // MARK: - Private Methods
    private func trackNetworkRequestSuccess(
        success: Bool,
        error: Error?
    ) {
        var requestState: String = ""
        
        if success {
            requestState = success ? "Success" : "Failed"
        }
        
        analytics.send("SignUp-" + requestState)
    }
}
