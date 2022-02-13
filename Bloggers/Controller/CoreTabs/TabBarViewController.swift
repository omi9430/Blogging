//
//  TabBarViewController.swift
//  Bloggers
//
//  Created by omair khan on 08/02/2022.
//

import UIKit

class TabBarViewController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        self.tabBar.backgroundColor = .white
        setUpControllers()
    }
    
    
    
    private func setUpControllers() {
        
        let home = HomeViewController()
        home.title = "Home"
        home.navigationItem.largeTitleDisplayMode = .always
        
        
        let profile = ProfileViewController()
        profile.title = "Profile"
        profile.navigationItem.largeTitleDisplayMode = .always
        
        
        
        let homeNav = UINavigationController(rootViewController: home)
        homeNav.navigationBar.prefersLargeTitles = true
        homeNav.navigationBar.largeTitleTextAttributes = [.foregroundColor: UIColor.white]
        
        let profileNav = UINavigationController(rootViewController: profile)
        profileNav.navigationBar.prefersLargeTitles = true
        profileNav.navigationBar.largeTitleTextAttributes = [.foregroundColor: UIColor.white]
        
        homeNav.tabBarItem = UITabBarItem(title: "house", image: UIImage(systemName: "house"), tag: 1)
        profileNav.tabBarItem = UITabBarItem(title: "Profile", image: UIImage(systemName: "person.circle"), tag: 1)
        
        setViewControllers([homeNav,profileNav], animated: true)
        
        
        
    }

   
}
