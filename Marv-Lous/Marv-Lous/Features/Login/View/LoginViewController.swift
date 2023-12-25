//
//  LoginViewController.swift
//  Marv-Lous
//
//  Created by Erik Egers on 2022/04/01.
//

import Foundation
import UIKit

class LoginViewController: UIViewController {
    
    @IBOutlet private weak var usernameTextField: UITextField!
    @IBOutlet private weak var passwordTextField: UITextField!
    
    private lazy var loginPageViewModel = LoginViewModel(delegate: self)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupTextFields()
    }
    
    @IBAction private func loginButtonPressed(_ sender: UIButton) {
        loginPageViewModel.attemptLogin(usernameTextField.text, passwordTextField.text)
    }
    
    func setupTextFields() {
        usernameTextField.delegate = self
        passwordTextField.delegate = self
    }
}

// MARK: - UITextFieldDelegate
extension LoginViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        usernameTextField.resignFirstResponder()
        passwordTextField.resignFirstResponder()
        return true
    }

    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        view.endEditing(true)
    }
}

// MARK: - LoginViewModelDelegate
extension LoginViewController: LoginViewModelDelegate {
    func showError(_ error: String) {
        usernameTextField.text = ""
        passwordTextField.text = ""
        self.showAlert(title: "Login unsuccesful",
                       message: error,
                       button: "Retry")
    }
    
    func navigateToLandingPage() {
        performSegue(withIdentifier: "goToLandingPage", sender: self)
    }
}
