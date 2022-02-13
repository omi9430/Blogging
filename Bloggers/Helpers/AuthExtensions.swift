//
//  AuthValidation.swift
//  Bloggers
//
//  Created by omair khan on 11/02/2022.
//

import Foundation
protocol AuthValidation {
    
    func isValid(email:String,password:String,confirmPassword:String) -> Bool
}

extension AuthValidation {
    
    func isValid(email:String,password:String,confirmPassword:String) -> Bool{
        
        let emailFormat = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
        let emailPredicate = NSPredicate(format:"SELF MATCHES %@", emailFormat)
        let predicatedEmail = emailPredicate.evaluate(with: email)
        
        
    }

}
