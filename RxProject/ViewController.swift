//
//  ViewController.swift
//  RxProject
//
//  Created by Ovidiu Bortas on 1/16/20.
//  Copyright © 2020 Detroit Labs. All rights reserved.
//

import RxCocoa
import RxSwift

class ViewController: UIViewController {

    // MARK: - UI Elements
    let usernameTextField = makeUsernameTextField()
    let passwordTextField = makePasswordTextField()
    let loginButton       = makeLoginButton()
    let usernameLabel     = makeUsernameLabel()
    let passwordLabel     = makePasswordLabel()

    let viewModel = ViewModel()

    override func viewDidLoad() {
        super.viewDidLoad()
        setup()

        loginButton.addTarget(self, action: #selector(didTapLogin), for: .touchUpInside)
    }

    @objc func didTapLogin() {
        let username = usernameTextField.text ?? ""
        let password = passwordTextField.text ?? ""
        viewModel.networkManager.attemptLogin(username: username, password: password) { (userAccount) in

            guard let userAccount = userAccount else {
                return presentLoginFailedAlert()
            }

            goToHomeScreen(with: userAccount)
        }
    }

    func bindLoginButton() {

    }
}

struct UserAccount {
    let username: String
    let age: Int
}
class ViewModel {
    let networkManager = NetworkManager()
}
class NetworkManager {
    func attemptLogin(username: String, password: String, completion: (UserAccount?) -> Void) {
        let account = Bool.random() ? UserAccount(username: "JohnDoe123", age: 50) : nil
        completion(account)
    }

    func attemptLogin(username: String, password: String) -> Observable<UserAccount?> {
        let account = Bool.random() ? UserAccount(username: "JohnDoe123", age: 50) : nil
        return Observable<UserAccount?>.of(account)
    }
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

private func makeUsernameLabel() -> UILabel {
    let label = UILabel(frame: .zero)
    label.text = "username text"
    return label
}

private func makePasswordLabel() -> UILabel {
    let label = UILabel(frame: .zero)
    label.text = "password text"
    return label
}

import SnapKit
// MARK: - Helpers
extension ViewController {

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.isNavigationBarHidden = true
    }

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

        let labelStackView = UIStackView(arrangedSubviews: [usernameLabel, passwordLabel])
        labelStackView.axis = .vertical
        labelStackView.spacing = 24

        view.addSubview(labelStackView)

        labelStackView.snp.makeConstraints { (make) in
            make.top.equalTo(loginButton.snp.bottom).offset(48)
            make.leading.equalToSuperview().offset(24)
            make.trailing.equalToSuperview().offset(-24)
        }


    }

    func presentLoginFailedAlert() {
        let alert = UIAlertController(title: "Login", message: "Invalid credentials.", preferredStyle: .alert)
        alert.addAction(.init(title: "Dismiss", style: .cancel))
        present(alert, animated: true)
    }

    func goToHomeScreen(with userAccount: UserAccount) {
        let viewController = UIViewController(nibName: nil, bundle: nil)
        viewController.view.backgroundColor = .white
        viewController.title = userAccount.username
        navigationController?.isNavigationBarHidden = false

        navigationController?.pushViewController(viewController, animated: true)
    }
}

// MARK: - UITextFieldDelegate
extension ViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        self.view.endEditing(true)
        return true
    }
}

