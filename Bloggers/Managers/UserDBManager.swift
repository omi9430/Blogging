//
//  UserDBManager.swift
//  Bloggers
//
//  Created by omair khan on 14/02/2022.
//

import Foundation
import UIKit
import FirebaseFirestore


class UserDBManager {
    
    
    private let database = Firestore.firestore()
    
    func insertUser(user: UserModel, completion: @escaping(Bool) -> Void) {
        
        let documentID = user.email
            .replacingOccurrences(of: ".", with: "_")
            .replacingOccurrences(of: "@", with: "_")
        
        // data to store
        let data = [
            "name": user.name,
            "email": user.email,
        ]
        
        database
            .collection("users")
            .document(documentID)
            .setData(data) { error in
                
                if error == nil {
                    completion(true)
                } else {
                    completion(false)
                }
            }
        
    }
    
    func uploadProfilePicture(user: UserModel,image: UIImage,completion : @escaping(Bool) -> Void) {
        
    }
    
    func downloadProfilePicture(user: UserModel, completion:@escaping(URL?) -> Void){
        
    }
}
