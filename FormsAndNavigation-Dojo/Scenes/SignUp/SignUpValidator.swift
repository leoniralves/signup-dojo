//
//  SignUpValidator.swift
//  FormsAndNavigation-Dojo
//
//  Created by Gabriel Pereira on 11/03/22.
//

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
        return (false, "")
    }
    
    func getValidPassword(password: String?) -> (valid: Bool, value: String) {
        return (false, "")
    }
    
}
