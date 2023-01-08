//
//  RegistrationViewModel.swift
//  Testagram
//
//  Created by Ramazan Rustamov on 07.01.23.
//

import Foundation

final class RegistrationViewModel {
    
    func validateEmail(_ email: String) -> Bool {
        let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
        
        let emailPredicate = NSPredicate(format:"SELF MATCHES %@", emailRegEx)
        return emailPredicate.evaluate(with: email)
    }
    
    func validatePassword(_ password: String) -> Bool {
        if password.count <= 6 || password.count >= 12 {
            return false
        } else {
            return true
        }
    }
    
    func validateAge(_ age: String) -> Bool {
        guard let ageInteger = Int(age) else {return false}
        
        if ageInteger <= 18 || ageInteger >= 99 {
            return false
        } else {
            return true
        }
    }
    
    func saveEmail(_ email: String) {
        RepositoryController.setUserDefaultsValue(value: email, key: RepositoryController.Constants.EMAIL)
    }
    
    func savePassword(_ password: String) {
        RepositoryController.setUserDefaultsValue(value: password, key: RepositoryController.Constants.PASSWORD)
    }
    
    func checkRegistrationCredentials(email: String, password: String) -> Bool {
        guard let registeredEmail = RepositoryController.getUserDefaultsValue(key: RepositoryController.Constants.EMAIL) as? String,
              let registeredPassword = RepositoryController.getUserDefaultsValue(key: RepositoryController.Constants.PASSWORD) as? String
        else { return false }
        
        if email == registeredEmail && password == registeredPassword {
            return true
        } else {
            return false
        }
    }
    
}
