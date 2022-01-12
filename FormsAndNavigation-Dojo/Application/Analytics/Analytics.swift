//
//  Analytics.swift
//  FormsAndNavigation-Dojo
//
//  Created by Kauê Sales on 12/01/22.
//

import Foundation


class Analytics {
    
    static let shared: Analytics = .init()
    
    private var isConfigured: Bool = false
    
    private init() {}
    
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
