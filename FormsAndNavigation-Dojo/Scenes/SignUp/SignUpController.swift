//
//  SignUpController.swift
//  FormsAndNavigation-Dojo
//
//  Created by Leonir Deolindo on 10/01/22.
//

import UIKit

class SignUpController: UIViewController {
    // MARK: - Properties
    private let viewModel: SignUpViewModelProtocol
    private let presenter: SignUpPresenterProtocol
    
    // MARK: - UIComponents
    let inputFirstName: UITextField = .init()
    let inputLastName: UITextField = .init()
    let inputAge: UITextField = .init()
    let inputEmail: UITextField = .init()
    let inputPassword: UITextField = .init()
    
    init(
        viewModel: SignUpViewModelProtocol,
        presenter: SignUpPresenterProtocol
    ) {
        self.viewModel = viewModel
        self.presenter = presenter
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = viewModel.title
        view.backgroundColor = .lightGray
        
        inputFirstName.placeholder = viewModel.inputFirstName
        inputLastName.placeholder = viewModel.inputLastName
        inputAge.placeholder = viewModel.inputAge
        inputEmail.placeholder = viewModel.inputEmail
        inputPassword.placeholder = viewModel.inputPassword
        
        let textFieldArray: [UITextField] = [
            inputFirstName,
            inputLastName,
            inputAge,
            inputEmail,
            inputPassword
        ]
        
        textFieldArray.forEach {
            $0.borderStyle = .roundedRect
            $0.backgroundColor = .white
            $0.textColor = .black
            $0.attributedPlaceholder = NSAttributedString(
                string: $0.placeholder ?? "",
                attributes: [NSAttributedString.Key.foregroundColor: UIColor.lightGray]
            )
        }
        
        let signUpButton: UIButton = .init(type: .system)
        signUpButton.setTitle(viewModel.signUpButton, for: .normal)
        signUpButton.addTarget(self, action: #selector(actionSignUp(_:)), for: .touchUpInside)
        
        let containerView: UIStackView = .init(
            arrangedSubviews: textFieldArray
        )
        containerView.addArrangedSubview(signUpButton)
        containerView.axis = .vertical
        containerView.spacing = 16
        
        containerView.translatesAutoresizingMaskIntoConstraints = false
        
        view.addSubview(containerView)
        containerView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 16).isActive = true
        containerView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 16).isActive = true
        containerView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -16).isActive = true
    }
    
    @objc func actionSignUp(_ sender: UIButton) {
        let networker: Networker = .init()
        let target: Networker.Target = .signUp(
            firstName: inputFirstName.text!,
            lastName: inputLastName.text!,
            age: inputAge.text!,
            email: inputEmail.text!,
            password: inputPassword.text!
        )
        
        networker.request(target: target) { result in
            presenter.trackNetworkRequest(result: result)
        }
    }
}
