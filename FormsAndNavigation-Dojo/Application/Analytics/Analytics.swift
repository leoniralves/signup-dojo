//
//  Analytics.swift
//  FormsAndNavigation-Dojo
//
//  Created by Kauê Sales on 12/01/22.
//

import Foundation

protocol AnalyticsProtocol {
    func configuration()
    func send(_ event: String)
}

class Analytics: AnalyticsProtocol {
    // MARK: - Properties
    private var isConfigured: Bool = false
    static let shared: Analytics = .init()

    // MARK: - Initializer Methods
    private init() {}
    
    // MARK: - Public and Internal Methods
    func configuration() {
        isConfigured = true
        print(">>> \(Self.self) IS configured!")
    }
    
    func send(_ event: String) {
        guard isConfigured else {
            print(">>> \(Self.self) IS NOT configured!")
            return
        }
        print(">> \(Self.self) send event: \(event)")
    }
}
