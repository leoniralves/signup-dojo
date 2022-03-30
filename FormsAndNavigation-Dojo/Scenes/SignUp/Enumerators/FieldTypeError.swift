//
//  FieldTypeError.swift
//  FormsAndNavigation-Dojo
//
//  Created by Gabriel Pereira on 30/03/22.
//

struct SignUpFormErrors: Error {
    var errors: [FieldTypeError]
}

enum FieldTypeError: Error {
    case name
    case email
    case password
}
