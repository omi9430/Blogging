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
    func signOut(completion: @escaping(Bool) -> Void) 
}


class AuthManager : authFunctions {
    
    
    static let shared = AuthManager()
    
    let auth = Auth.auth()
    
    func isSignedIn() -> Bool {
        
        let isLogedIn = auth.currentUser != nil ? true : false
        return isLogedIn
    }
    
    func signUp(email: String, password: String, confirmPassword: String, completion: @escaping (Bool) -> Void) {
        
        auth.createUser(withEmail: email, password: password) { authResult, error in
            
            guard authResult != nil ,error == nil else {
                print(error?.localizedDescription)
                completion(false)
                return
            }
            
            completion(true)
            
        }
        
    }
    
    func login(email: String, password: String, completion: @escaping (Bool) -> Void) {
        
        auth.signIn(withEmail: email, password: password) {authResult, error in
            
            print(authResult)
            guard error == nil else {
                print(error?.localizedDescription)
                completion(false)
                return
            }
            completion(true)
        }
    }
    
    func signOut(completion: @escaping (Bool) -> Void) {
        
        do{
            try auth.signOut()
            completion(true)
        }catch{
            print(error)
            completion(false)
        }
    }
   
    
    
  
    
    
   
    
    
}
