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
    // MARK: - Public and Internal Methods
    func getValidFirstName(name: String?) -> (valid: Bool, value: String) {
        let firstName: String = name ?? ""
        
        let firstNameRegex: String = "([A-Za-z]+){10,30}"
        let predicate: NSPredicate = NSPredicate(format: "SELF MATCHES %@", firstNameRegex)
        let isValid: Bool = predicate.evaluate(with: firstName)
        
        return (isValid, firstName)
    }
    
    func getValidEmail(email: String?) -> (valid: Bool, value: String) {
        let email: String = email ?? ""
        
        // Testar regex com este formato: ^[0-9?A-z0-9?]+(\.)?[0-9?A-z0-9?]+@[A-z]+\.[A-z]{3}.?[A-z]{0,3}$
        let emailRegex: String = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,}"
        let predicate: NSPredicate = NSPredicate(format: "SELF MATCHES %@", emailRegex)
        let isValid: Bool = predicate.evaluate(with: email)

        return (isValid, email)
    }
    
    func getValidPassword(password: String?) -> (valid: Bool, value: String) {
        return (true, "")
    }
    
}
