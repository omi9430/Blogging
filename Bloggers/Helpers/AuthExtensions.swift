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

extension String {
    
    func isValidEmail() -> Bool {
        
        let emailFormat = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
        let emailPredicate = NSPredicate(format:"SELF MATCHES %@", emailFormat)
        return emailPredicate.evaluate(with: self)
    }
}
