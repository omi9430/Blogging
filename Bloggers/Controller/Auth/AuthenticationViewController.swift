//
//  AuthenticationViewController.swift
//  Bloggers
//
//  Created by omair khan on 08/02/2022.
//

import UIKit

class AuthenticationViewController: UIViewController, AuthValidation{
    
    /**
     - Title Label
     - Segmented Control
     - Email txtfield
     - Password txtfield
     - Confirm Passwrod txtField
     - Continue Button
     - Notification Label for Email
     - Notification Label for Password
     - Notification Label for Confirm Password
     */
    
 
    
    let segmentedControl : UISegmentedControl = {
        
        var sgControl = UISegmentedControl(items: ["Login", "Register"])
        sgControl.selectedSegmentTintColor = .blue
        sgControl.translatesAutoresizingMaskIntoConstraints = false
        sgControl.selectedSegmentIndex = 0
        return sgControl
    }()
    
    
    let emailTextField : UITextField = {
        
        var txtField = UITextField()
        txtField.textAlignment = .left
        txtField.clearsOnBeginEditing = true
        txtField.placeholder = "  Email"
        txtField.backgroundColor = .lightGray
        txtField.layer.cornerRadius = 5
        txtField.translatesAutoresizingMaskIntoConstraints = false
        return txtField
    }()
    
    
    let passwordTxtField : UITextField = {
        
        var txtField = UITextField()
        txtField.textAlignment = .left
        txtField.clearsOnBeginEditing = true
        txtField.isSecureTextEntry = true
        txtField.placeholder = "  Password"
        txtField.backgroundColor = .lightGray
        txtField.layer.cornerRadius = 5
        
        txtField.translatesAutoresizingMaskIntoConstraints = false
        return txtField
    }()
   
    let confirmPassword : UITextField = {
        
        var txtField = UITextField()
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
    
    let continueBtn : UIButton =  {
        
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
    
    let emailWarningLbl : UILabel = {
        
        let label = UILabel()
        label.textColor = .red
        label.font = UIFont(name: "Arial", size: 13)
        label.textAlignment = .left
        label.alpha = 0
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
        
    }()
    
    let passwordWarningLbl : UILabel = {
        
        let label = UILabel()
        label.textColor = .red
        label.font = UIFont(name: "Arial", size: 13)
        label.textAlignment = .left
        label.alpha = 0
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
        
    }()
    
    let confirmPassWarningLbl : UILabel = {
        
        let label = UILabel()
        label.textColor = .red
        label.font = UIFont(name: "Arial", size: 13)
        label.textAlignment = .left
        label.alpha = 0
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
        
    }()
    
    //MARK: Properties
    
    var confirmPassAnchor : NSLayoutConstraint?
    var continueBtnAnchor : NSLayoutConstraint?
    

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
       
        setUpViews()
    
        
        segmentedControl.addTarget(self, action: #selector(sengmentedControlValueChanged), for: .valueChanged)
        continueBtn.addTarget(self, action: #selector(continueBtnPressed), for: .touchUpInside)
        
       
    }
  
    
   
    
    //MARK: Button Actions
    
   
    // Segnmented Controls Actions
    @objc func sengmentedControlValueChanged(){
        if segmentedControl.selectedSegmentIndex == 0 {
            
            /**
             - Call Animate For SignUp
             - Hide Borders if they exisit
             - Hide Warning  labels
             - Confirm Password alpha set 0
             */
          
            
            animateforSingUp(yForBtn: 50, yForPass: -12)
            
            hideWarnings()
            
            self.confirmPassword.alpha = 0
            
        }else if segmentedControl.selectedSegmentIndex == 1 {
            
            animateforSingUp(yForBtn: 110, yForPass: 50)
        }
    }
     
    //MARK: Continue Button Actions
    @objc func continueBtnPressed() {
        
        if segmentedControl.selectedSegmentIndex == 1 {
           
            
            continueSingUp()
        }else{
            
            continueLoginIn()
        }
        
        
    }
    
   

}
