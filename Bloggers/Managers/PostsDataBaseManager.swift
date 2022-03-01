//
//  DataBaseManager.swift
//  Bloggers
//
//  Created by omair khan on 08/02/2022.
//

import Foundation
import FirebaseFirestore


class PostDataBaseManager{
    /**
     - Create database instance
     - Insert posts
     - Fetch All the posts
     - Get posts for specific user
     */
    
    
    
    
    private let database = Firestore.firestore()
    
    func inserPost(blogPost : BlogPost, user : UserModel, completion: @escaping(Bool) -> Void){
        
    }
    
    func getAllPost(completion: @escaping([BlogPost]) -> Void){
        
    }
    
    func blogPostForUser(user: UserModel, posts: BlogPost, completion:@escaping([BlogPost]) -> Void) {
        
    }
    
    func uploadHeaderImage(blogPost : BlogPost, image: UIImage, completion: @escaping(Bool) -> Void){
        
    }
    
    func downloadHeaderImage(blogPost:  BlogPost, completion:@escaping(URL?) -> Void){
        
    }
    
    private init(){}
}
