//
//  Networker.swift
//  FormsAndNavigation-Dojo
//
//  Created by Leonir Deolindo on 12/01/22.
//

import Foundation

class Networker {
    
    enum Method {
        case POST
        case GET
    }
    
    enum Target {
        case signUp(
            firstName: String,
            lastName: String,
            age: String,
            email: String,
            password: String
        )
        
        var endpoint: String {
            switch self {
            case .signUp:
                return "/signup"
            }
        }
        
        var method: Method {
            switch self {
            case .signUp:
                return .POST
            }
        }
        
        var params: [String: String] {
            switch self {
            case let .signUp(
                firstName,
                lastName,
                age,
                email,
                password
            ):
                return [
                    "firstName": firstName,
                    "lastName": lastName,
                    "age": age,
                    "email": email,
                    "password": password
                ]
            }
        }
    }
    
    func request(target: Target, completion: (Result<Bool, Error>)->Void) {
        print("Endpoint:", target.endpoint)
        print("Method:", target.method)
        print("Params:", target.params)
        
        completion(.success(true))
    }
}
