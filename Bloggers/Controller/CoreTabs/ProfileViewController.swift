//
//  ProfileViewController.swift
//  Bloggers
//
//  Created by omair khan on 08/02/2022.
//

import UIKit

class ProfileViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Sign Out", style: .done, target: self, action: #selector(didTapSignOut))
    }
    

    @objc func didTapSignOut() {
        // Sing out user
        AuthManager.shared.signOut {[weak self] success in
            
            // Remove email and name in User defaults
            UserDefaults.standard.set(nil,forKey:saveEmail)
            UserDefaults.standard.set(nil,forKey:saveName)
            
            // Present Auth View controller
            let vc = AuthenticationViewController()
            vc.modalPresentationStyle = .fullScreen
            self?.present(vc, animated: true, completion: nil)
        }
    }

}
