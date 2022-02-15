//
//  SignUpModel+Mock.swift
//  FormsAndNavigation-DojoTests
//
//  Created by Gabriel Pereira on 15/02/22.
//

@testable import FormsAndNavigation_Dojo

extension SignUpModel {
    static func make(
        firstName: String? = nil,
        lastName: String? = nil,
        age: String? = nil,
        email: String? = nil,
        password: String? = nil
    ) -> Self {
        .init(
            firstName: firstName,
            lastName: lastName,
            age: age,
            email: email,
            password: password
        )
    }
}
