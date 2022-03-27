//
//  ProfileViewController.swift
//  Bloggers
//
//  Created by omair khan on 08/02/2022.
//

import UIKit

class ProfileViewController: UIViewController, UITableViewDataSource, UITableViewDelegate, UIImagePickerControllerDelegate & UINavigationControllerDelegate {
   
    
    
    /**
     - TableView
     - ImageView for header
     - Email Label for header
     */
    
     let tableView: UITableView = {
        var tableView = UITableView()
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        return tableView
    }()
    
    
    private let imageView: UIImageView = {
        var imageView = UIImageView()
        imageView.layer.borderWidth = 1.0
        imageView.layer.masksToBounds = false
        imageView.layer.borderColor = UIColor.white.cgColor
        imageView.clipsToBounds = true
        imageView.contentMode =  .scaleAspectFill
        imageView.isUserInteractionEnabled = true
        return imageView
    }()
    
    private let headerLbl: UILabel =  {
        var label = UILabel()
        label.font = .systemFont(ofSize: 15, weight: .bold)
        label.textAlignment = .left
        return label
    }()
    
    
    
    // Required Dependencies
    let email: String?
    let dbManager: UserDBManager?
    let postsManager : PostDataBaseManager?
    
    init(email: String, dbManager: UserDBManager, postManager:PostDataBaseManager ) {
        self.email  = email
        self.dbManager = dbManager
        self.postsManager = postManager
        super.init(nibName: nil, bundle: nil)
    }
    
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // Properties
    var blogPosts:[BlogPost] = []

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        setUpTableView()
        setupSignOutBtn()
        setUpHeader(profilePhoto: nil, name: nil)
        getUser()
        fetchPosts()
    }
    

    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        self.tableView.frame = view.bounds
    }
    
    
    // Setup TableView
    func setUpTableView() {
        self.view.addSubview(tableView)
        tableView.dataSource = self
        tableView.delegate = self
    }
    
    // SignOut Button
    func setupSignOutBtn() {
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Sign Out",
                                                            style: .done,
                                                            target: self,
                                                            action: #selector(didTapSignOut))
    }
    
    // TableView Header
    func setUpHeader(profilePhoto: String? ,name: String?) {
        
        let headerView = UIView(frame: CGRect(x: 0, y: 0,
                                              width: self.view.frame.width,
                                              height: self.view.frame.width/1.5))
        headerView.backgroundColor = .systemRed
        headerView.isUserInteractionEnabled = true
        headerView.clipsToBounds = true
        tableView.tableHeaderView = headerView
        
        // Tap gesture for imageView
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(selectProfilePicture))
        
        // Profile Picture
        imageView.frame = CGRect(x: 2,
                                 y: (headerView.frame.height/2) - (self.view.frame.height/12),
                                 width: self.view.frame.width/3,
                                 height: self.view.frame.width/3)
        imageView.image = UIImage(systemName: "person.circle")
        imageView.layer.cornerRadius = imageView.frame.size.width / 2
        imageView.addGestureRecognizer(tapGesture)
        headerView.addSubview(imageView)
        
        
       
        
        // Email
        headerLbl.frame = CGRect(x: view.frame.width/3 + 5,
                                 y: headerView.frame.height/2,
                                 width: view.frame.width/1.5,
                                 height: 25)
        
        headerLbl.text = email
        headerView.addSubview(headerLbl)
        
        // if name param is passed
        if let name = name {
            title = name
        }
        
        // if photoURL is passed
        if let profilePhoto = profilePhoto {
            
            fetchImage(imagePath: profilePhoto, imageView: self.imageView)
        }
    }
    
    // Fetch User From DB
    func getUser() {
        guard let dbManager = dbManager else {
            return
        }

        dbManager.getUserFromDB(email: email!, completion: {[weak self] user in
            
            guard let user = user else {
                return
            }
            DispatchQueue.main.async {
                print(user.profileRef)
                self?.setUpHeader(profilePhoto: user.profileRef ?? "_", name: user.name)
            }
            
            
        })
    }
    
    // Fetch User Image and Assign to the Display Picture image View
    func fetchImage(imagePath: String,imageView: UIImageView) {
        
        // Download URL
        dbManager?.downloadProfilePicture(path: imagePath, completion: { url in
           
            guard let url = url else {
                return
            }
            
            // Download Image from URL
           let task = URLSession.shared.dataTask(with: url) { data, response, error in
                guard error == nil,
                      let data = data  else {
                    print(error?.localizedDescription)
                    return
                }
                
               // Set Image to ImageView on main thread
                DispatchQueue.main.async {
                    imageView.image = UIImage(data: data)
                }
           }
            task.resume()
        })
        
    }
    
    // Select picture for profile
    @objc func selectProfilePicture() {
        
        /// The guard statemet will help prevent the user to change other user profile picture
        
        guard let myEmail = UserDefaults.standard.value(forKey: saveEmail) as? String,
              myEmail == email  else {
            return
        }
        
        // Create a imagePicker Controller
        let imagePicker = UIImagePickerController()
        imagePicker.sourceType = .photoLibrary
        imagePicker.allowsEditing = true
        imagePicker.delegate = self
        self.present(imagePicker, animated: true, completion: nil)
        
    }

    @objc func didTapSignOut() {
        // Sing out user
        AuthManager.shared.signOut {[weak self] success in
            
            if success {
                
                // Remove email and name in User defaults
                UserDefaults.standard.set(nil,forKey: saveEmail)
                UserDefaults.standard.set(nil,forKey: saveName)
                
                // Present Auth View controller
                let vc = AuthenticationViewController()
                vc.modalPresentationStyle = .fullScreen
                self?.present(vc, animated: true, completion: nil)
            }
         
        }
    }

}
