//
//  AuthValidation.swift
//  Bloggers
//
//  Created by omair khan on 11/02/2022.
//

import Foundation

enum AuthErrors : Error {
    case emailNotValid
    case passwordIsNotValid
    case passwordNotMatched
    case passwordIsEmpty
    case emailIsEmpty
    case allFieldsEmpty
}


/// This Protocol will validated user credentials

protocol AuthValidation {
    func validate(email: String, password: String, confirmPassword: String, completion:(Bool) -> Void ) throws -> Void
}

extension AuthValidation {
    
    func validate(email: String, password: String, confirmPassword: String, completion:(Bool) -> Void ) throws -> Void {
        
        if !email.isValidEmail() && !email.isEmpty {
            
            throw AuthErrors.emailNotValid
            
        }else if password.count < 6 && !password.isEmpty{
            
            throw AuthErrors.passwordIsNotValid
            
        }else if password != confirmPassword && !password.isEmpty && !confirmPassword.isEmpty{
            
            throw AuthErrors.passwordNotMatched
            
        }else if password.isEmpty && confirmPassword.isEmpty && !email.isEmpty{
            
            throw AuthErrors.passwordIsEmpty
            
        }else if email.isEmpty && !password.isEmpty{
            throw AuthErrors.emailIsEmpty
        
        }else if password.isEmpty && email.isEmpty && confirmPassword.isEmpty {
            throw AuthErrors.allFieldsEmpty
        }else{
            
            return completion(true)
            
        }
    }
    
}


