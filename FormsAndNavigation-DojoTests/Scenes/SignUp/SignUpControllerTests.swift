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
        XCTAssertEqual(sut.title, mockViewModel.title)
    }
    
    func test_inputLastNamePlaceholder_shouldBeValid() {
        XCTAssertEqual(sut.inputLastName.placeholder, mockViewModel.inputLastName)
    }

    func test_inputFirstNamePlaceholder_shouldBeValid() {
        XCTAssertEqual(sut.inputFirstName.placeholder, mockViewModel.inputFirstName)
    }
    
    func test_inputAgeNamePlaceholder_shouldBeValid() {
        XCTAssertEqual(sut.inputAge.placeholder, mockViewModel.inputAge)
    }

    // Colocar em funcoes separadas
    func test_placeholders_shouldAssertCorrectValues() {
        XCTAssertEqual(sut.inputPassword.placeholder, mockViewModel.inputPassword)
        XCTAssertEqual(sut.inputLastName.placeholder, mockViewModel.inputLastName)
        XCTAssertEqual(sut.inputFirstName.placeholder, mockViewModel.inputFirstName)
        XCTAssertEqual(sut.inputAge.placeholder, mockViewModel.inputAge)
        XCTAssertEqual(sut.inputEmail.placeholder, mockViewModel.inputEmail)
    }
}
