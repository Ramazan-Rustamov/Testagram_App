//
//  RegistrationViewController.swift
//  Testagram
//
//  Created by Ramazan Rustamov on 07.01.23.
//

import UIKit

final class RegistrationViewController: UIViewController {
    
    private let viewModel = RegistrationViewModel()

    @IBOutlet weak var headerLabel: UILabel!
    
    @IBOutlet weak var emailTextfield: UITextField!
    
    @IBOutlet weak var ageTextfield: UITextField!
    
    @IBOutlet weak var passwordTextfield: UITextField!
    
    @IBOutlet weak var registerButton: UIButton!
    
    @IBOutlet weak var emailWarningLabel: UILabel!
    
    @IBOutlet weak var ageWarningLabel: UILabel!
    
    @IBOutlet weak var passwordWarningLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        setupTextfields()
        setupButton()
        setupLabels()
        addDoneButtonOnKeyboard()
    }

    
    @IBAction func registerButtonTapped(_ sender: Any) {
        guard let email = emailTextfield.text , let age = ageTextfield.text , let password = passwordTextfield.text else { return }
        
        emailWarningLabel.isHidden = true
        ageWarningLabel.isHidden = true
        passwordWarningLabel.isHidden = true
        
        guard !email.isEmpty else {
            emailWarningLabel.isHidden = false
            emailWarningLabel.text = "Please enter your email"
            return
        }
        
        guard !age.isEmpty else {
            ageWarningLabel.isHidden = false
            ageWarningLabel.text = "Please enter your age"
            return
        }
        
        guard !password.isEmpty else {
            passwordWarningLabel.isHidden = false
            passwordWarningLabel.text = "Please enter your password"
            return
        }
        
        guard viewModel.validateEmail(email) else {
            emailWarningLabel.isHidden = false
            emailWarningLabel.text = "Invalid email"
            return
        }
        
        guard viewModel.validateAge(age) else {
            ageWarningLabel.isHidden = false
            ageWarningLabel.text = "Invalid age"
            return
        }
        
        guard viewModel.validatePassword(password) else {
            passwordWarningLabel.isHidden = false
            passwordWarningLabel.text = "Password must be between 6 and 12 characters long"
            return
        }
        
        viewModel.saveEmail(email)
        viewModel.savePassword(password)
        
        navigationController?.pushViewController(FeedViewController(), animated: true)
    }
    
    private func setupTextfields() {
        emailTextfield.delegate = self
        ageTextfield.delegate = self
        passwordTextfield.delegate = self
        
        emailTextfield.placeholder = "Enter your email"
        ageTextfield.placeholder = "Enter your age"
        passwordTextfield.placeholder = "Enter your password"
        
        emailTextfield.layer.borderWidth = 0.5
        ageTextfield.layer.borderWidth = 0.5
        passwordTextfield.layer.borderWidth = 0.5
        
        emailTextfield.layer.borderColor = UIColor.black.cgColor
        ageTextfield.layer.borderColor = UIColor.black.cgColor
        passwordTextfield.layer.borderColor = UIColor.black.cgColor
        
        emailTextfield.layer.cornerRadius = 7
        ageTextfield.layer.cornerRadius = 7
        passwordTextfield.layer.cornerRadius = 7
        
        passwordTextfield.isSecureTextEntry = true
        
        ageTextfield.keyboardType = .numberPad
    }
    
    private func setupButton() {
        registerButton.layer.cornerRadius = 7
    }
    
    private func setupLabels() {
        emailWarningLabel.adjustsFontSizeToFitWidth = true
        ageWarningLabel.adjustsFontSizeToFitWidth = true
        passwordWarningLabel.adjustsFontSizeToFitWidth = true
    }
    
}

extension RegistrationViewController: UITextFieldDelegate {
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
        
        emailTextfield.inputAccessoryView = doneToolbar
        ageTextfield.inputAccessoryView = doneToolbar
        passwordTextfield.inputAccessoryView = doneToolbar
    }
    
    // Usually I create one big custom TextField class and use it everywhere. There I do all the background work (delegate functions, keyboard functions and etc), so I do not need to mention all the textfields to resign first responder as I did here. For me this kind of code is bad , but due to limited time I have no choice. Please take into consideration
    @objc internal func doneButtonAction(){
        emailTextfield.resignFirstResponder()
        ageTextfield.resignFirstResponder()
        passwordTextfield.resignFirstResponder()
    }
}
