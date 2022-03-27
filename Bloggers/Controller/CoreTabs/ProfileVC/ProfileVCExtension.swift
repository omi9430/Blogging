//
//  ProfileVCExtension.swift
//  Bloggers
//
//  Created by omair khan on 02/03/2022.
//

import Foundation
import UIKit

extension ProfileViewController {
    
    // MARK: Fetch User Posts
    
    func fetchPosts(){
        postsManager?.blogPostForUser(email: email!, completion: {[weak self] posts in
            
            self?.blogPosts = posts
            
            DispatchQueue.main.async {
                self?.tableView.reloadData()
            }
           
        })
    }
   
    
    // MARK: TableView Data Source
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return blogPosts.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        cell.textLabel?.text = blogPosts[indexPath.row].title
        return cell
    }
    
    // MARK: TableView Delegate
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let vc = ViewPostViewController()
        vc.title = blogPosts[indexPath.row].title
        let navVC = UINavigationController(rootViewController: vc)
        self.present(navVC, animated: true, completion: nil)
    }
    
    func tableView(_ tableView: UITableView, didDeselectRowAt indexPath: IndexPath) {
        
    }
    
    // MARK: Image Picker Controller Delegates
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        self.dismiss(animated: true, completion: nil)
    }
    
    func imagePickerController(_ picker: UIImagePickerController,didFinishPickingMediaWithInfo
                               info: [UIImagePickerController.InfoKey : Any]) {
        
        /// get edited image as UIImage
        guard let image = info[.editedImage] as? UIImage,
              let email = email else {
            return
        }
        
        // Dismiss image Picker
        self.dismiss(animated: true) { [weak self] in
            // upload the selected image to the storage
            self?.dbManager?.uploadProfilePicture(email: email, image: image, completion: { success in
                
                guard success else {
                    return
                }
                // Update the reference for "profile_photo" in the DB
                self?.dbManager?.updateProfilePicture(email: email, completion: { success in
                        
                DispatchQueue.main.async {
                        self?.getUser()
                    }
                    
                })
            })
        }
    }
}
