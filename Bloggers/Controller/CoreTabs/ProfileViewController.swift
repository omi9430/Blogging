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
    

    @objc func didTapSignOut(){
        
    }

}
