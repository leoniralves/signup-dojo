//
//  SignUpControllerTests.swift
//  FormsAndNavigation-DojoTests
//
//  Created by Magno Ferreira on 12/01/22.
//

import XCTest
@testable import FormsAndNavigation_Dojo

class SignUpControllerTests: XCTestCase {
    // MARK: - Properties
    private let mockViewModel: SignUpViewModelMock = .init()
    
    // MARK: - Computed Properties
    private lazy var sut: SignUpController = {
        let sut: SignUpController = .init(
            viewModel: mockViewModel,
            presenter: SignUpPresenter()
        )
        sut.loadViewIfNeeded()

        return sut
    }()
    
    // MARK: - Test Methods
    func test_title_shouldBeValid() {
        XCTAssertEqual(sut.title, mockViewModel.title)
    }
    
    func test_inputLastName_shouldPlaceHolderProvidedByViewModelValue() {
        XCTAssertEqual(sut.inputLastName.placeholder, mockViewModel.inputLastName)
    }

    func test_inputFirstName_shouldPlaceHolderProvidedByViewModelValue() {
        XCTAssertEqual(sut.inputFirstName.placeholder, mockViewModel.inputFirstName)
    }
    
    func test_inputAge_shouldPlaceHolderProvidedByViewModelValue() {
        XCTAssertEqual(sut.inputAge.placeholder, mockViewModel.inputAge)
    }

    func test_inputPassword_shouldPlaceHolderProvidedByViewModelValue() {
        XCTAssertEqual(sut.inputPassword.placeholder, mockViewModel.inputPassword)
    }
    
    func test_inputEmail_shouldPlaceHolderProvidedByViewModelValue() {
        XCTAssertEqual(sut.inputEmail.placeholder, mockViewModel.inputEmail)
    }
}
