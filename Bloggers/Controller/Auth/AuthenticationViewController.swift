//
//  AuthenticationViewController.swift
//  Bloggers
//
//  Created by omair khan on 08/02/2022.
//

import UIKit

class AuthenticationViewController: UIViewController, AuthValidation{
    
    /**
     - Segmented Control
     - Name txtfield
     - Email txtfield
     - Password txtfield
     - Confirm Passwrod txtField
     - Continue Button
     - Notification Label for Email
     - Notification Label for Password
     - Notification Label for Confirm Password
     */
    
 
    
    let segmentedControl: UISegmentedControl = {
        
        var sgControl = UISegmentedControl(items: ["Login", "Register"])
        sgControl.selectedSegmentTintColor = .blue
        sgControl.translatesAutoresizingMaskIntoConstraints = false
        sgControl.selectedSegmentIndex = 0
        return sgControl
    }()
    
    let nameTxtField: UITextField = {
        
        var txtField = UITextField()
        txtField.leftViewMode = .always
        txtField.clearsOnBeginEditing = true
        txtField.placeholder = "  Enter Full Name"
        txtField.backgroundColor = .lightGray
        txtField.layer.cornerRadius = 5
        txtField.alpha = 0
        
        txtField.translatesAutoresizingMaskIntoConstraints = false
        return txtField
    }()
    
    let emailTextField: UITextField = {
        
        var txtField = UITextField()
        txtField.leftViewMode = .always
        txtField.textAlignment = .left
        txtField.clearsOnBeginEditing = true
        txtField.placeholder = "  Email"
        txtField.backgroundColor = .lightGray
        txtField.layer.cornerRadius = 5
        txtField.translatesAutoresizingMaskIntoConstraints = false
        return txtField
    }()
    
    
    let passwordTxtField: UITextField = {
        
        var txtField = UITextField()
        txtField.leftViewMode = .always
        txtField.textAlignment = .left
        txtField.clearsOnBeginEditing = true
        txtField.isSecureTextEntry = true
        txtField.placeholder = "  Password"
        txtField.backgroundColor = .lightGray
        txtField.layer.cornerRadius = 5
        
        txtField.translatesAutoresizingMaskIntoConstraints = false
        return txtField
    }()
   
    let confirmPassword: UITextField = {
        
        var txtField = UITextField()
        txtField.leftViewMode = .always
        txtField.textAlignment = .left
        txtField.clearsOnBeginEditing = true
        txtField.isSecureTextEntry = true
        txtField.placeholder = "  Confirm Password"
        txtField.backgroundColor = .lightGray
        txtField.layer.cornerRadius = 5
        txtField.alpha = 0
        txtField.translatesAutoresizingMaskIntoConstraints = false
        return txtField
    }()
    
    let continueBtn: UIButton =  {
        
        var btn = UIButton()
        btn.setTitle("Continue", for: .normal)
        btn.titleLabel?.textColor = .white
        btn.titleLabel?.textAlignment = .center
        btn.titleLabel?.font = UIFont(name: "Arial-BoldMT", size: 20)
        btn.backgroundColor = .blue
        btn.layer.cornerRadius = 5
        btn.translatesAutoresizingMaskIntoConstraints = false
        
        return btn
    }()
    
    let emailWarningLbl: UILabel = {
        
        let label = UILabel()
        label.textColor = .red
        label.font = UIFont(name: "Arial", size: 13)
        label.textAlignment = .left
        label.alpha = 0
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
        
    }()
    
    let passwordWarningLbl: UILabel = {
        
        let label = UILabel()
        label.textColor = .red
        label.font = UIFont(name: "Arial", size: 13)
        label.textAlignment = .left
        label.alpha = 0
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
        
    }()
    
    let confirmPassWarningLbl: UILabel = {
        
        let label = UILabel()
        label.textColor = .red
        label.font = UIFont(name: "Arial", size: 13)
        label.textAlignment = .left
        label.alpha = 0
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
        
    }()
    
    // MARK: Properties
    
    var confirmPassAnchor: NSLayoutConstraint?
    var continueBtnAnchor: NSLayoutConstraint?
    var segmentAnchor: NSLayoutConstraint?
    var nameAnchor: NSLayoutConstraint?
    
    
    let userDataBase = UserDBManager()
    

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
       /**
        - Call Setup Views
        - Add Button targets
        - Check if user is premium
        */
       
        setUpViews()
    
        
        segmentedControl.addTarget(self, action: #selector(sengmentedControlValueChanged), for: .valueChanged)
        continueBtn.addTarget(self, action: #selector(continueBtnPressed), for: .touchUpInside)
        
        if  !IAPManager.shared.isPremium(){
            
            DispatchQueue.main.asyncAfter(deadline: .now() + 3) {
                
                let navigationVC = UINavigationController(rootViewController: InAppPurchasesViewController())
                self.present(navigationVC, animated: true, completion: nil)
            }
        }
        
        
       
    }
  
    
   
    
    // MARK: Button Actions
    
   
    // Segnmented Controls Actions
    @objc func sengmentedControlValueChanged(){
        if segmentedControl.selectedSegmentIndex == 0 {
            
            /**
             - Call Animate For SignUp
             - Hide Borders if they exisit
             - Hide Warning  labels
             - Confirm Password alpha set 0
             */
            
            // Animate for login
            
            animateforSingUp(yForBtn: 50, yForPass: -12, yForName: -70, yForSegment: -140, isLogin: true)
            
            hideWarnings()
            
            
            
        }else if segmentedControl.selectedSegmentIndex == 1 {
            
            // Animate for Signup
            animateforSingUp(yForBtn: 110, yForPass: 50, yForName: -130, yForSegment: -200, isLogin: false)
        }
    }
     
    // MARK: Continue Button Actions
    @objc func continueBtnPressed() {
        
        if segmentedControl.selectedSegmentIndex == 1 {
            
            // Action to perform when Singup is selected
            continueSingUp()
        } else {
            // Action to perform when Login is selected
            continueLoginIn()
        }
    }
}
