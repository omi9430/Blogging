//
//  DataBaseManager.swift
//  Bloggers
//
//  Created by omair khan on 08/02/2022.
//

import Foundation
import FirebaseFirestore
import FirebaseStorage


class PostDataBaseManager{
    /**
     - Create database instance
     - Insert posts
     - Fetch All the posts
     - Get posts for specific user
     */
    
    
    
    
    private let database = Firestore.firestore()
    private let storeageContainer = Storage.storage()
    
    func inserPost(blogPost: BlogPost, email: String, completion: @escaping(Bool) -> Void) {
        
        /// Get Document ID
        let documentId = email.emailPath()
        
        
        // Create Dictionary of Data to send
        let data: [String:Any] = [
            "id": blogPost.identifier,
            "title": blogPost.title,
            "body": blogPost.text,
            "createAt": blogPost.timeStamp,
            "imageURL": blogPost.headerImage?.absoluteString,
        ]
        
        database
            .collection("users")
            .document(documentId)
            .collection("posts")
            .document(blogPost.identifier)
            .setData(data) { error in
                guard error == nil else {
                    print(error?.localizedDescription)
                    completion(false)
                    return
                }
                completion(true)
            }
            
        
            
    }
    
    func getAllPost(completion: @escaping([BlogPost]) -> Void) {
        
    }
    
    func blogPostForUser(email: String,completion:@escaping([BlogPost]) -> Void) {
        
        let documentId = email.emailPath()
        
        // Retrieve posts from Database
        database
            .collection("users")
            .document(documentId)
            .collection("posts")
            .getDocuments { snapShot, error in
                guard let data = snapShot?.documents.compactMap{ $0.data() },
                error == nil else {
                    return
                }
                
                let posts:[BlogPost] = data.compactMap { dictionary in
                    guard let id = dictionary["id"] as? String,
                          let title = dictionary["title"] as? String,
                          let body = dictionary["body"]as? String,
                          let created = dictionary["createAt"] as? TimeInterval,
                          let imageURL = dictionary["imageURL"] as? String else {
                              
                              return nil
                          }
                    
                    let post = BlogPost(identifier: id,
                                        title: title,
                                        text: body,
                                        timeStamp: created,
                                        headerImage: URL(string: imageURL))
                    return post
                }
                completion(posts)
            }
    }
    
    func uploadHeaderImage(email: String,postId: String, image: UIImage, completion: @escaping(Bool) -> Void) {
        /// Convert image to PNG
        guard let image = image.pngData() else {
            return
        }
        // Create email path 
        let path = email.emailPath()
        
        /// Upload the png image to the storeage
        storeageContainer
            .reference(withPath:"blog_header_image/\(path)/\(postId).png")
            .putData(image, metadata: nil) { _, error in
                
                guard error == nil else {
                    print(error?.localizedDescription)
                    completion(false)
                    return
                }
                completion(true)
            }
    }
    
    func downloadHeaderImageURL(email: String,postId: String, completion:@escaping(URL?) -> Void) {
        
        let path = email.emailPath()
        
        storeageContainer
            .reference(withPath: "blog_header_image/\(path)/\(postId).png")
            .downloadURL { url, error in
                
                guard error == nil else {
                    print(error?.localizedDescription)
                    return
                }
                completion(url)
            }
        
    }
    
   
}
