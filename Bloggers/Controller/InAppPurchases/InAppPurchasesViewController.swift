//
//  InAppPurchasesViewController.swift
//  Bloggers
//
//  Created by omair khan on 15/02/2022.
//

import UIKit

class InAppPurchasesViewController: UIViewController {
    
    
    /**
     - Header View
     - DescriptionView
     - Subscribe Button
     - Term of Services  Label
     */
    
    private let headerView : UIView =  {
        
        var view = IAPHeaderView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
        
    }()
   
    private let descriptionView : UIView =  {
        
        var view = IAPDescritpion()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
        
    }()

    private let subscribeBtn : UIButton  = {
       
        var button = UIButton()
        button.backgroundColor  = .purple
        button.setTitle("Subscribe", for: .normal)
        button.titleLabel?.textColor = .white
        button.layer.cornerRadius = 5
        button.titleLabel?.font = .systemFont(ofSize: 22, weight: .heavy)

        button.translatesAutoresizingMaskIntoConstraints =  false
        return button
        
    }()
    
    private let restorePurchase : UIButton  = {
       
        var button = UIButton()
        button.setTitle("Restore Purchases", for: .normal)
        button.setTitleColor(.blue, for: .normal)
        button.translatesAutoresizingMaskIntoConstraints =  false
        return button
        
    }()
    
    
    private let termOfServices : UILabel = {
       
        var label = UILabel()
        
        label.textAlignment = .center
        label.textColor = .systemGray
        label.font = .systemFont(ofSize: 10, weight: .heavy)
        label.numberOfLines = 0
        label.translatesAutoresizingMaskIntoConstraints = false
        
        
        label.text = """
Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris.
"""
        
        
        return label
        
        
    }()
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        self.view.backgroundColor = .white
        setUpViews()
        setUpNav()
        
        self.restorePurchase.addTarget(self, action: #selector(restoreBtnPressed), for: .touchUpInside)
        self.subscribeBtn.addTarget(self, action: #selector(subscribeBtnPressed), for: .touchUpInside)
    }
    
   
    func setUpViews() {
        
            /**
             - Add SubViews
             - Add Constraints
             - Activate Contstraints
             */
        
        let guides = self.view.safeAreaLayoutGuide
        
        self.view.addSubview(headerView)
        self.view.addSubview(subscribeBtn)
        self.view.addSubview(descriptionView)
        self.view.addSubview(restorePurchase)
        self.view.addSubview(termOfServices)
        
        let constraints = [
            
            self.headerView.topAnchor.constraint(equalTo: guides.topAnchor, constant: 0),
            self.headerView.leadingAnchor.constraint(equalTo: guides.leadingAnchor, constant: 0),
            self.headerView.trailingAnchor.constraint(equalTo: guides.trailingAnchor, constant: 0),
            self.headerView.heightAnchor.constraint(equalToConstant: self.view.frame.height/3),
            
            self.descriptionView.topAnchor.constraint(equalTo: self.headerView.bottomAnchor, constant: 0),
            self.descriptionView.leadingAnchor.constraint(equalTo: guides.leadingAnchor, constant: 0),
            self.descriptionView.trailingAnchor.constraint(equalTo: guides.trailingAnchor, constant: 0),
            self.descriptionView.heightAnchor.constraint(equalToConstant: self.view.frame.height/3),
            
            
            self.subscribeBtn.topAnchor.constraint(equalTo: self.descriptionView.bottomAnchor, constant: 20),
            self.subscribeBtn.centerXAnchor.constraint(equalTo: self.view.centerXAnchor, constant: 0),
            self.subscribeBtn.widthAnchor.constraint(equalTo: self.view.widthAnchor, constant: -40),
            self.subscribeBtn.heightAnchor.constraint(equalToConstant: 80 ),
            
            self.restorePurchase.topAnchor.constraint(equalTo: self.subscribeBtn.bottomAnchor, constant: 5),
            self.restorePurchase.centerXAnchor.constraint(equalTo: self.view.centerXAnchor, constant: 0),
            self.restorePurchase.widthAnchor.constraint(equalTo: self.view.widthAnchor, constant: -60),
            
            self.termOfServices.topAnchor.constraint(equalTo: self.restorePurchase.bottomAnchor, constant: 5),
            self.termOfServices.bottomAnchor.constraint(equalTo: guides.bottomAnchor, constant: 5),
            self.termOfServices.centerXAnchor.constraint(equalTo: self.view.centerXAnchor, constant: 0),
            self.termOfServices.widthAnchor.constraint(equalTo: self.view.widthAnchor, constant: -10) ,
            
        ]
        
        NSLayoutConstraint.activate(constraints)
        
        
    }
    
    // Set Up Nav-Bar
    
    func setUpNav() {
        self.title = "Bloggers Premium"
        
        let rightBarBtn = UIBarButtonItem(image: UIImage(systemName: "cross.fill"), style: .plain, target: self, action: #selector(self.closeBtnPressed))
        
        self.navigationItem.rightBarButtonItem = rightBarBtn
        
    }
    
    
    // MARK: Buttons actions
    
    
    // Close Btn
    @objc func closeBtnPressed() {
        
        self.dismiss(animated: true, completion: nil)
    }
    
    // Restore Btn
    
    @objc func restoreBtnPressed(){
        
        IAPManager.shared.restorePurchase { [weak self] success in
            
            if success {
                // if successfuly subscribed dismiss the current view
                self?.dismiss(animated: true, completion: nil)
            } else {
                // failed to restore
                let aletSheet = UIAlertController(title: "Restore Failed", message: "Couldn't restore your purchase", preferredStyle: .alert)
                aletSheet.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
                self?.present(aletSheet, animated: true, completion: nil)
            }
        }
    }
    
    // Subscribe Btn
    
    @objc func subscribeBtnPressed() {
        
        IAPManager.shared.getPurchasesPackages { package in
            
            guard let package = package else {
                print("Error finidng packages")
                return
            }
            // Pass the package to subscribe method
            IAPManager.shared.subscribe(package: package) {[weak self] success in
                if success {
                    // if successfuly subscribed dismiss the current view
                    self?.dismiss(animated: true, completion: nil)
                } else {
                    // If not subscribed show alert
                    let aletSheet = UIAlertController(title: "Purchase Failed", message: "Failed to subscribe", preferredStyle: .alert)
                    aletSheet.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
                    self?.present(aletSheet, animated: true, completion: nil)
                }
                
            }
            
            
        }
        
        
    }
 

}
