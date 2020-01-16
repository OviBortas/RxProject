//
//  ViewController.swift
//  RxProject
//
//  Created by Ovidiu Bortas on 1/16/20.
//  Copyright © 2020 Detroit Labs. All rights reserved.
//

import UIKit
import SnapKit

class ViewController: UIViewController {

    let usernameTextField = makeUsernameTextField()
    let passwordTextField = makePasswordTextField()
    let loginButton = makeLoginButton()

    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
    }

    init() { super.init(nibName: nil, bundle: nil) }
    required init?(coder: NSCoder) { fatalError() }
}

// MARK: - Make Views
private func makeUsernameTextField() -> UITextField {
    let textField = UITextField(frame: .zero)
    textField.borderStyle = .roundedRect
    textField.placeholder = "Enter username"

    return textField
}

private func makePasswordTextField() -> UITextField {
    let textField = UITextField(frame: .zero)
    textField.borderStyle = .roundedRect
    textField.placeholder = "Enter password"

    return textField
}

private func makeLoginButton() -> UIButton {
    let button = UIButton(type: .roundedRect)
    button.setTitle("Login", for: .normal)
    return button
}

// MARK: - Helpers
extension ViewController {

    func setup() {
        view.backgroundColor = .white
        usernameTextField.delegate = self
        passwordTextField.delegate = self
        layoutView()
    }

    func layoutView() {
        let credentialsStackView = UIStackView(arrangedSubviews: [usernameTextField, passwordTextField])
        credentialsStackView.axis = .vertical
        credentialsStackView.spacing = 12

        view.addSubview(credentialsStackView)
        view.addSubview(loginButton)

        usernameTextField.snp.makeConstraints { (make) in
            make.height.equalTo(50)
        }

        passwordTextField.snp.makeConstraints { (make) in
            make.height.equalTo(50)
        }

        credentialsStackView.snp.makeConstraints { (make) in
            make.leading.equalToSuperview().offset(16)
            make.trailing.equalToSuperview().offset(-16)
            make.top.equalToSuperview().offset(100)
        }

        let offset = 32 * 3

        loginButton.snp.makeConstraints { (make) in
            make.top.equalTo(credentialsStackView.snp.bottom).offset(32)
            make.leading.equalToSuperview().offset(offset)
            make.trailing.equalToSuperview().offset(-offset)
        }
    }
}

// MARK: - UITextFieldDelegate
extension ViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        self.view.endEditing(true)
        return true
    }
}

