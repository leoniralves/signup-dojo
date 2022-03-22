//
//  SignUpValidator.swift
//  FormsAndNavigation-Dojo
//
//  Created by Gabriel Pereira on 11/03/22.
//

import Foundation

protocol SignUpValidatorProtocol {
    func getValidFirstName(name: String?) -> (valid: Bool, value: String)
    func getValidEmail(email: String?) -> (valid: Bool, value: String)
    func getValidPassword(password: String?) -> (valid: Bool, value: String)
}

class SignUpValidator: SignUpValidatorProtocol {
    // MARK: - Properties
    private let firstNameRange: ClosedRange<Int> = 10...30
    
    // MARK: - Public and Internal Methods
    func getValidFirstName(name: String?) -> (valid: Bool, value: String) {
        let firstName: String = name ?? ""
        let firstNameIsValid: Bool = firstNameRange ~= firstName.count
        
        return (firstNameIsValid, firstName)
    }
    
    func getValidEmail(email: String?) -> (valid: Bool, value: String) {
        let email: String = email ?? ""
        let emailRegex: String = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,}"
        let predicate: NSPredicate = NSPredicate(format: "SELF MATCHES %@", emailRegex)
        
        let isValid: Bool = predicate.evaluate(with: email)

        return (isValid, email)
    }
    
    func getValidPassword(password: String?) -> (valid: Bool, value: String) {
        return (false, "")
    }
    
}
