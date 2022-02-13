//
//  AuthManager.swift
//  Bloggers
//
//  Created by omair khan on 08/02/2022.
//

import Foundation
import FirebaseAuth

protocol authFunctions {
    func isSignedIn() -> Bool
    func signUp(email : String, password: String , confirmPassword: String, completion: @escaping(Bool) -> Void)
    func login(email: String, password:String, completion:  @escaping(Bool) -> Void)
    func signOut(completion: @escaping(Bool) -> Void) -> Bool
}


class AuthManager : authFunctions {
    
    
    
    private let auth = Auth.auth()
    
    func isSignedIn() -> Bool {
        
        let isLogedIn = auth.currentUser != nil ? true : false
        return isLogedIn
    }
    
    func signUp(email: String, password: String, confirmPassword: String, completion: @escaping (Bool) -> Void) {
        
        
    }
    
    func login(email: String, password: String, completion: @escaping (Bool) -> Void) {
        
        
    }
    
    func signOut(completion: @escaping (Bool) -> Void) -> Bool {
        
        return true
    }
   
    
    
  
    
    
   
    
    
}
