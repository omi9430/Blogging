//
//  UserDBManager.swift
//  Bloggers
//
//  Created by omair khan on 14/02/2022.
//

import Foundation
import UIKit
import FirebaseFirestore
import FirebaseStorage

class UserDBManager {
    
    
    private let database = Firestore.firestore()
    private let storeageContainer = Storage.storage()
    
    func insertUser(user: UserModel, completion: @escaping(Bool) -> Void) {
        
        let documentID = user.email.emailPath()
        
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
    
    // Fetch Current user from the DB
    func getUserFromDB( email: String, completion: @escaping(UserModel?) -> Void) {
        
        // Id for the user ref in db
        
        let documentID = email.emailPath()
        
        // fetch data
        database
            .collection("users")
            .document(documentID)
            .getDocument { snapShot, error in
                
                guard let data = snapShot?.data() as? [String:String],
                      let name = data["name"],
                          error == nil else {
                    print(error?.localizedDescription)
                    return
                }
                print(name)
                let ref = data["profile_photo"]
                
                // Create User Model
                let user = UserModel(name: name, email: email, profileRef: ref)
                
                // Retrun User
                completion(user)
            }
        
        
    }
    
    
    // Upload User selected profile picture to the storage
    func uploadProfilePicture(email: String, image: UIImage,completion : @escaping(Bool) -> Void) {
        
        /// Convert UIImage to PNG
        guard let image = image.pngData() else {
            return
        }
        
        let path = email.emailPath()
        
        /// Upload image to database
        storeageContainer
            .reference(withPath: "profile_photo/\(path)/photo.png")
            .putData(image, metadata: nil) { _, error in
                print(image)
                guard error == nil else {
                    completion(false)
                    print(error?.localizedDescription)
                    return
                }
                completion(true)
            }
        
    }
    
    
    func updateProfilePicture(email: String, completion:@escaping(Bool)  -> Void) {
        
        /** Once you uploaded the picture to the storage this function will update the value for key 'profile_photo'
        in Users Data base with latest reference  of image in the storage or create a new one  **/
        
        let documentID = email.emailPath()
        let imageReference = "profile_photo/\(documentID)/photo.png"
        
        // get the reference to current user records in DB
        let dbRef = database
                        .collection("users")
                        .document(documentID)
        
        // fetch the current user records
            dbRef.getDocument { snapShot, error in
                
                guard var data = snapShot?.data(),
                      error == nil else {
                          return
                      }
                // update the value and send back the data
                data["profile_photo"] = imageReference
                dbRef.setData(data) { error in
                    completion(error == nil)
                }
            }
        
    }
    

        // Download the URL for the user image
    func downloadProfilePicture(path: String, completion:@escaping(URL?) -> Void){
        
        /// This function takes a reference for the image  in storage and returns the URL for image
    
        let path = path
        
        storeageContainer
            .reference(withPath: path)
            .downloadURL { url, error in
                print(url)
                guard error == nil else {
                    print(error?.localizedDescription)
                    return
                }
                print(url)
                completion(url)
            }
        
    }
}
