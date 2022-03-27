//
//  ViewController.swift
//  Bloggers
//
//  Created by omair khan on 08/02/2022.
//

import UIKit

class HomeViewController: UIViewController {
    
    // Composing button
    private let composeButton: UIButton = {
        var button = UIButton()
        button.layer.cornerRadius = 40
        button.backgroundColor = .white
        button.setImage(UIImage(systemName: "square.and.pencil",
                                withConfiguration: UIImage.SymbolConfiguration(pointSize:42, weight:.medium)),
                                for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.layer.shadowOpacity = 0.4
        button.layer.shadowColor = UIColor.label.cgColor
        button.layer.shadowRadius = 10
        return button
    }()

    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        self.view.backgroundColor = .link
        composeButton.addTarget(self, action: #selector(didTapCompose), for: .touchUpInside)
        setUpView()
    }
    
    
    func setUpView() {
         
        self.view.addSubview(composeButton)
        
        let constraints = [
            composeButton.leadingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: -85),
            composeButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -10),
            composeButton.widthAnchor.constraint(equalToConstant: 80),
            composeButton.heightAnchor.constraint(equalToConstant: 80)
        ]
        
        NSLayoutConstraint.activate(constraints)
    }
    
    @objc func didTapCompose(){
        let vc = CreateNewPostViewController()
        vc.title = "Create Post"
        let navVc = UINavigationController(rootViewController: vc)
        self.present(navVc, animated: true)
    }
}

