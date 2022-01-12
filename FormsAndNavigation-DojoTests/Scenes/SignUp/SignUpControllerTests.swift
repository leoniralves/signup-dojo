//
//  SignUpControllerTests.swift
//  FormsAndNavigation-DojoTests
//
//  Created by Magno Ferreira on 12/01/22.
//

import XCTest
@testable import FormsAndNavigation_Dojo

class SignUpControllerTests: XCTestCase {

    private lazy var sut: SignUpController = {
        let sut: SignUpController = .init()
        sut.loadViewIfNeeded()

        return sut
    }()

    func test_namePlaceholder() {
        XCTAssertEqual(sut.inputFirstName.placeholder, "banana-maça")
    }
}
