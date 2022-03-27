//
//  CreateNewPostViewController.swift
//  Bloggers
//
//  Created by omair khan on 08/02/2022.
//

import UIKit

class CreateNewPostViewController: UIViewController, UINavigationControllerDelegate {
    
    /**
     - Title textField
     - Header Image
     - Post textField
     */
    
    private let titleTxtField: UITextField = {
       
        var txtField = UITextField()
        txtField.placeholder = "Title"
        txtField.autocapitalizationType = .words
        txtField.autocorrectionType = .yes
        txtField.translatesAutoresizingMaskIntoConstraints = false
        txtField.backgroundColor = .secondarySystemBackground
        return txtField
    
    }()
    
    private let headerImage: UIImageView = {
        
        var imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.backgroundColor = .blue
        imageView.image = UIImage(systemName: "photo")
        imageView.isUserInteractionEnabled = true
        imageView.layer.masksToBounds = true
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    private let postTxtField: UITextView = {
       
        var txtView = UITextView()
        txtView.isEditable = true
        txtView.font = .systemFont(ofSize: 28)
        txtView.translatesAutoresizingMaskIntoConstraints = false
        txtView.backgroundColor = .secondarySystemBackground
        
        return txtView
    
    }()
    
    private var selectedImage: UIImage?
    private let imageTap = UITapGestureRecognizer()
    private let dataBaseManager = PostDataBaseManager()

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        self.view.backgroundColor = .white
        navButtons()
        setUpView()
        imageTap.addTarget(self, action: #selector(didTapHeaderImage))
        headerImage.addGestureRecognizer(imageTap)
        
    }
    

    private func setUpView(){
        
        self.view.addSubview(titleTxtField)
        self.view.addSubview(headerImage)
        self.view.addSubview(postTxtField)
        
        let constraints = [
            //title text Field
            titleTxtField.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor, constant: 2),
            titleTxtField.centerXAnchor.constraint(equalTo: self.view.centerXAnchor),
            titleTxtField.widthAnchor.constraint(equalToConstant: self.view.frame.width - 20 ),
            titleTxtField.heightAnchor.constraint(equalToConstant: 50),
            
            // Header Image
            headerImage.topAnchor.constraint(equalTo: self.titleTxtField.bottomAnchor, constant: 5),
            headerImage.centerXAnchor.constraint(equalTo: self.view.centerXAnchor),
            headerImage.widthAnchor.constraint(equalToConstant: self.view.frame.width ),
            headerImage.heightAnchor.constraint(equalToConstant: 160),
            
            // Post text field
            postTxtField.topAnchor.constraint(equalTo: self.headerImage.bottomAnchor, constant: 2),
            postTxtField.centerXAnchor.constraint(equalTo: self.view.centerXAnchor),
            postTxtField.widthAnchor.constraint(equalToConstant: self.view.frame.width - 20 ),
            postTxtField.bottomAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.bottomAnchor, constant: -3)
        ]
        
        NSLayoutConstraint.activate(constraints)
    }

    //MARK: Configure Nav Buttons
    private func navButtons() {
        
    navigationItem.leftBarButtonItem = UIBarButtonItem(title: "Cancel",
                                     style: .done,
                                     target: self,
                                     action: #selector(didTapCancel))
        
    navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Post",
                                         style: .done,
                                         target: self,
                                         action: #selector(didTapPost))
    }
    
    //MARK: did Tap HeaderImage
    @objc private func didTapHeaderImage() {
        
        let picker = UIImagePickerController()
        picker.delegate = self
        picker.sourceType = .photoLibrary
        self.present(picker, animated: true)
    }
    
    //MARK: did tap Cancel
    @objc private func didTapCancel() {
        self.dismiss(animated: true, completion: nil)
    }
    
    //MARK: did tap Post
    @objc private func didTapPost() {
        /**
         - No textfield should be empty else throw an error
         - selected  Image should not be nill
         */
  guard let title = titleTxtField.text,
        let body = postTxtField.text,
        let headerImage = selectedImage,
        let email = UserDefaults.standard.string(forKey: saveEmail),
        !title.trimmingCharacters(in: .whitespaces).isEmpty,
        !body.trimmingCharacters(in: .whitespaces).isEmpty else {
            
            // Show user alert
            let alert = UIAlertController(title: "Please Fix The Errors", message: "Make sure you've entered a title,body and selected an image", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "Ok", style: .cancel, handler: .none))
            present(alert, animated: true, completion: nil)
            
            return
        }
        
        let postId = UUID().uuidString
        /**
         - Upload the header Image to DB
         - Retrieve the image URL
         - Upload the article to profile with image URL
         */
        
        dataBaseManager.uploadHeaderImage(email: email,
                                          postId: postId,
                                          image: headerImage) { [weak self] success in
            
            if success {
                // Download URL for the Header Image
                self?.dataBaseManager.downloadHeaderImageURL(email: email,
                                                       postId: postId) { url in
                    guard let url = url else {
                        print("Cannot find URL")
                        return
                    }
                    
                    // Insert Post to DB
                    let blogPost = BlogPost(identifier: postId,
                                            title: title,
                                            text: body,
                                            timeStamp: Date().timeIntervalSince1970,
                                            headerImage: url)
                    self?.dataBaseManager.inserPost(blogPost: blogPost, email: email, completion: { success in
                        
                        if !success {
                            print("Failed to insert Post")
                        }else{
                            print("Post inserted Successfully")
                            self?.dismiss(animated: true, completion: nil)
                        }
                    })
                    
                }
            }else {
                print("Error uploading Image")
            }
        }
        
    }
}

extension CreateNewPostViewController: UIImagePickerControllerDelegate {
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        // Code to execute if user cancel picking the image
        self.dismiss(animated: true, completion: nil)
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        
        // Code that executes after user has picked an Image
        self.dismiss(animated: true, completion: nil)
        guard let image = info[.originalImage] as? UIImage else {
            return
        }
        selectedImage = image
        headerImage.image = selectedImage
    }
}
