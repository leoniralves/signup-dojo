//
//  SignUpControllerTests.swift
//  FormsAndNavigation-DojoTests
//
//  Created by Magno Ferreira on 12/01/22.
//

import XCTest
@testable import FormsAndNavigation_Dojo

class SignUpControllerTests: XCTestCase {

    private let mockViewModel: SignUpViewModelMock = .init()
    
    private lazy var sut: SignUpController = {
        let sut: SignUpController = .init(viewModel: mockViewModel)
        sut.loadViewIfNeeded()

        return sut
    }()
    
    func test_title_shouldBeValid() {
        XCTAssertEqual(sut.title, "dummyTitle")
    }
    
    func test_inputLastNamePlaceholder_shouldBeValid() {
        XCTAssertEqual(sut.inputLastName.placeholder, "dummyInputLastName")
    }

    func test_inputFirstNamePlaceholder_shouldBeValid() {
        XCTAssertEqual(sut.inputFirstName.placeholder, "dummyInputFirstName")
    }
    
    func test_inputAgeNamePlaceholder_shouldBeValid() {
        XCTAssertEqual(sut.inputAge.placeholder, "dummyInputAge")
    }
}
