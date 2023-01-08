//
//  HomeViewController.swift
//  Testagram
//
//  Created by Ramazan Rustamov on 07.01.23.
//

import UIKit

final class HomeViewController: UIViewController {
    
    private let viewModel = RegistrationViewModel()
    
    @IBOutlet weak var headerLabel: UILabel!
    
    @IBOutlet weak var usernameTextfield: UITextField!
    
    @IBOutlet weak var passwordTextfield: UITextField!
    
    @IBOutlet weak var signInButton: UIButton!
    
    @IBOutlet weak var registerButton: UIButton!
    
    @IBOutlet weak var emailWarningLabel: UILabel!
    
    @IBOutlet weak var passwordWarningEmail: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupTextfields()
        setupButtons()
        setupLabels()
        addDoneButtonOnKeyboard()
    }

    @IBAction func signInButtonTapped(_ sender: Any) {
        guard let email = usernameTextfield.text , let password = passwordTextfield.text else {return}
        
        emailWarningLabel.isHidden = true
        passwordWarningEmail.isHidden = true
        
        guard !email.isEmpty else {
            
            emailWarningLabel.isHidden = false
            emailWarningLabel.text = "Please enter your email"
            
            return
        }
        
        guard !password.isEmpty else {
            passwordWarningEmail.isHidden = false
            passwordWarningEmail.text = "Please enter your password"
            return
        }
        
        guard viewModel.validateEmail(email) else {
            emailWarningLabel.isHidden = false
            emailWarningLabel.text = "Invalid email"
            return
        }
        
        guard viewModel.validatePassword(password) else {
            passwordWarningEmail.isHidden = false
            passwordWarningEmail.text = "Password must be between 6 and 12 characters long"
            return
        }
        
        guard viewModel.checkRegistrationCredentials(email: email, password: password) else {
            emailWarningLabel.isHidden = false
            emailWarningLabel.text = "User is not found"
            return
        }
        
        navigationController?.pushViewController(FeedViewController(), animated: true)
    }
    
    @IBAction func registerButtonTapped(_ sender: Any) {
        navigationController?.pushViewController(RegistrationViewController(), animated: true)
    }

    private func setupTextfields(){
        usernameTextfield.delegate = self
        passwordTextfield.delegate = self
        
        usernameTextfield.layer.borderWidth = 0.5
        usernameTextfield.layer.borderColor = UIColor.black.cgColor
        
        passwordTextfield.layer.borderWidth = 0.5
        passwordTextfield.layer.borderColor = UIColor.black.cgColor
        
        usernameTextfield.layer.cornerRadius = 7
        passwordTextfield.layer.cornerRadius = 7
        
        usernameTextfield.placeholder = "Enter your email"
        passwordTextfield.placeholder = "Enter your password"
        
        passwordTextfield.isSecureTextEntry = true
        
    }
    
    private func setupButtons() {
        signInButton.layer.cornerRadius = 7
        registerButton.layer.cornerRadius = 7
        
        registerButton.layer.borderWidth = 1
        registerButton.layer.borderColor = UIColor.link.cgColor
    }
    
    private func setupLabels() {
        emailWarningLabel.adjustsFontSizeToFitWidth = true
        passwordWarningEmail.adjustsFontSizeToFitWidth = true
    }

}

extension HomeViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
    internal func addDoneButtonOnKeyboard(){
        let doneToolbar: UIToolbar = UIToolbar(frame: CGRect.init(x: 0, y: 0, width: UIScreen.main.bounds.width, height: 50))
        doneToolbar.barStyle = .default
        
        let flexSpace = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
        let done: UIBarButtonItem = UIBarButtonItem(title: "Done", style: .done, target: self, action: #selector(self.doneButtonAction))
        
        doneToolbar.items = [flexSpace, done]
        doneToolbar.sizeToFit()
        
        usernameTextfield.inputAccessoryView = doneToolbar
        passwordTextfield.inputAccessoryView = doneToolbar
    }
    
    // Usually I create one big custom TextField class and use it everywhere. There I do all the background work (delegate functions, keyboard functions and etc), so I do not need to mention all the textfields to resign first responder as I did here. For me this kind of code is bad , but due to limited time I have no choice. Please take into consideration
    @objc internal func doneButtonAction(){
        usernameTextfield.resignFirstResponder()
        passwordTextfield.resignFirstResponder()
    }
}
