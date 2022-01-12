//
//  SignUpController.swift
//  FormsAndNavigation-Dojo
//
//  Created by Leonir Deolindo on 10/01/22.
//

import UIKit

class SignUpController: UIViewController {
    
    let inputFirstName: UITextField = .init()
    let inputLastName: UITextField = .init()
    let inputAge: UITextField = .init()
    let inputEmail: UITextField = .init()
    let inputPassword: UITextField = .init()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Teste"
        view.backgroundColor = .lightGray
        
        inputFirstName.placeholder = "Nome"
        inputLastName.placeholder = "Sobrenome"
        inputAge.placeholder = "Idade"
        inputEmail.placeholder = "Email"
        inputPassword.placeholder = "Senha"
        
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
        signUpButton.setTitle("Cadastrar", for: .normal)
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
            switch result {
            case .success(let success):
                if success {
                    Analytics.shared.send("SignUp-Success")
                } else {
                    Analytics.shared.send("SignUp-Failed")
                }
            case .failure(let _):
                Analytics.shared.send("SignUp-Error")
            }
        }
    }
    
}

class Analytics {
    
    static let shared: Analytics = .init()
    
    private var isConfigured: Bool = false
    
    private init() {}
    
    func configuration() {
        isConfigured = true
        print(">>> \(Self.self) IS configured!")
    }
    
    func send(_ event: String) {
        guard isConfigured else {
            print(">>> \(Self.self) IS NOT configured!")
            return
        }
        print(">> \(Self.self) send event: \(event)")
    }
}
