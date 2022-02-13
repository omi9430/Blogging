//
//  AuthenticationFunctionsExtensions.swift
//  Bloggers
//
//  Created by omair khan on 11/02/2022.
//

import Foundation
import UIKit


extension AuthenticationViewController {
    
    
    
    
    //MARK: Continue for SignUp
    func continueSingUp(){
        do{
            try validate(email: emailTextField.text ?? "", password: passwordTxtField.text ?? "", confirmPassword: confirmPassword.text ?? "",completion: { success in
                if success {
                    
                    //TODO: SignUp

                }
            })
            
        }catch let errors as AuthErrors{
            
            switch errors {
            case .emailNotValid:
                
                self.emailWarningLbl.text = "Please Enter A Valid Email"
                animateWarnings(label: emailWarningLbl, allLabels: nil, txtField: emailTextField, txtFieldList: nil)
                
            case .passwordNotMatched:
                
                self.passwordWarningLbl.text = "Your password doesn't match"
                animateWarnings(label: passwordWarningLbl, allLabels: nil, txtField: passwordTxtField, txtFieldList: nil)
                
            case .passwordIsEmpty:
                
                self.passwordWarningLbl.text = "Password Is Required"
                animateWarnings(label: passwordWarningLbl, allLabels: nil, txtField: passwordTxtField, txtFieldList: nil)
                
            case .emailIsEmpty:
                
                self.emailWarningLbl.text = "Email is required"
                animateWarnings(label: emailWarningLbl, allLabels: nil, txtField: emailTextField, txtFieldList: nil)
                
            case .passwordIsNotValid:
                
                self.passwordWarningLbl.text = "Password should be at least 6 chracter ling"
                animateWarnings(label: passwordWarningLbl, allLabels: nil, txtField: passwordTxtField, txtFieldList: nil)
            
            case .allFieldsEmpty:
                
                self.emailWarningLbl.text = "Email is required"
                self.passwordWarningLbl.text = "Password Is Required"
                self.confirmPassWarningLbl.text = "This field is Required"
                
                animateWarnings(label: nil, allLabels: [emailWarningLbl,passwordWarningLbl,confirmPassWarningLbl], txtField: nil, txtFieldList: [passwordTxtField,emailTextField,confirmPassword])
      
            }
           
            
        }catch{
            print("Unexpected Error")
        }
    }
    
  //MARK: Continue to Login
    func continueLoginIn(){
        
        //TODO: Login
        
    }
    
    
    
    //MARK: Animations
    
    //MARK: Animations To Show Warning
    func animateWarnings(label: UILabel?, allLabels: [UILabel]?, txtField : UITextField?,txtFieldList : [UITextField]?){
        
        //Animate All Labels
        if allLabels != nil {
            
            confirmPassAnchor?.isActive = true
            for i in 0...allLabels!.count - 1{
                
                UIView.animate(withDuration: 0.5) {
        
                    let color = UIColor.red
                    allLabels![i].alpha  = 1
                    txtFieldList![i].borderStyle = .roundedRect
                    txtFieldList![i].layer.borderWidth = 1.0
                    txtFieldList![i].layer.borderColor = color.cgColor
       
                    self.view.layoutIfNeeded()
                } completion: { success in
                    //TODO: Vibration
                   
                }
                
            }
          
        }
        
        // Animate only one label
        if label != nil {
            
            UIView.animate(withDuration: 0.5) {
                guard let txtField = txtField else{
                    return
                }
                let color = UIColor.red
                label!.alpha = 1
                txtField.borderStyle = .roundedRect
                txtField.layer.borderWidth = 1.0
                txtField.layer.borderColor = color.cgColor
            } completion: { success in
                //TODO: Vibration
            }

        }
    }
    
    //MARK: Animation For SignUp
    func animateforSingUp(yForBtn: CGFloat,yForPass: CGFloat ){
     
        continueBtnAnchor?.isActive = false
        confirmPassAnchor?.isActive = false
        
        confirmPassAnchor =  self.confirmPassword.centerYAnchor.constraint(equalTo: self.view.centerYAnchor, constant: yForPass)
        
       // continueBtnAnchor =   continueBtn.centerYAnchor.constraint(equalTo: self.view.centerYAnchor, constant: 110)
        continueBtnAnchor =  self.continueBtn.centerYAnchor.constraint(equalTo: self.view.centerYAnchor, constant: yForBtn)
        confirmPassAnchor?.isActive = true
        continueBtnAnchor?.isActive = true
        UIView.animate(withDuration: 1) {
       
            
            self.confirmPassword.alpha = 1
            self.view.layoutIfNeeded()
            self.view.superview?.layoutIfNeeded()
      
        }
    }
    
    //MARK: Hide Warnings
    
    func hideWarnings(){
        
        let textFields = [confirmPassword,passwordTxtField,emailTextField]
        let labels = [emailWarningLbl,passwordWarningLbl,confirmPassWarningLbl]
        
        let color = UIColor.clear
        
        for i in 0...textFields.count - 1 {
            
            textFields[i].borderStyle = .none
            textFields[i].layer.borderColor = color.cgColor
            
            labels[i].alpha = 0
        }
        
    }
    
    
    
    
    
    
    //MARK: Setup Views
    func setUpViews(){
        
        /**
         - Background Color
         - Add SubViews
         - Add Constraints
         - Activate Constraints
         */
        
        self.view.backgroundColor = .white
        
        
        self.view.addSubview(segmentedControl)
        self.view.addSubview(emailTextField)
        self.view.addSubview(passwordTxtField)
        self.view.addSubview(confirmPassword)
        self.view.addSubview(continueBtn)
        self.view.addSubview(emailWarningLbl)
        self.view.addSubview(passwordWarningLbl)
        self.view.addSubview(confirmPassWarningLbl)
        
        
        
        let constraints = [
            
            //Email warning label
            emailWarningLbl.centerYAnchor.constraint(equalTo:  self.emailTextField.centerYAnchor, constant: 28),
            emailWarningLbl.centerXAnchor.constraint(equalTo: self.view.centerXAnchor, constant: 0),
            emailWarningLbl.widthAnchor.constraint(equalTo: self.view.widthAnchor, constant: -80),
            emailWarningLbl.heightAnchor.constraint(equalToConstant: 15),
            
            //Password warning label
            passwordWarningLbl.centerYAnchor.constraint(equalTo:  self.passwordTxtField.centerYAnchor, constant: 28),
            passwordWarningLbl.centerXAnchor.constraint(equalTo: self.view.centerXAnchor, constant: 0),
            passwordWarningLbl.widthAnchor.constraint(equalTo: self.view.widthAnchor, constant: -80),
            passwordWarningLbl.heightAnchor.constraint(equalToConstant: 15),

            //confirmPass warning label
            confirmPassWarningLbl.centerYAnchor.constraint(equalTo:  self.confirmPassword.centerYAnchor, constant: 28),
            confirmPassWarningLbl.centerXAnchor.constraint(equalTo: self.view.centerXAnchor, constant: 0),
            confirmPassWarningLbl.widthAnchor.constraint(equalTo: self.view.widthAnchor, constant: -80),
            confirmPassWarningLbl.heightAnchor.constraint(equalToConstant: 15),
            
            
            // segmented control
            segmentedControl.centerXAnchor.constraint(equalTo: self.view.centerXAnchor, constant: 0),
            segmentedControl.centerYAnchor.constraint(equalTo: self.view.centerYAnchor, constant: -140),
            segmentedControl.widthAnchor.constraint(equalTo: self.view.widthAnchor, constant: -40),
            segmentedControl.heightAnchor.constraint(equalToConstant: 60),
            
            // Email
            emailTextField.centerXAnchor.constraint(equalTo: self.view.centerXAnchor, constant: 0),
            emailTextField.centerYAnchor.constraint(equalTo: self.view.centerYAnchor, constant: -70),
            emailTextField.widthAnchor.constraint(equalTo: self.view.widthAnchor, constant: -60),
            emailTextField.heightAnchor.constraint(equalToConstant: 40),
            
            //Password
            passwordTxtField.centerXAnchor.constraint(equalTo: self.view.centerXAnchor, constant: 0),
            passwordTxtField.centerYAnchor.constraint(equalTo: self.view.centerYAnchor, constant: -12),
            passwordTxtField.widthAnchor.constraint(equalTo: self.view.widthAnchor, constant: -60),
            passwordTxtField.heightAnchor.constraint(equalToConstant: 40),
            
            // Confirm Password
            
            confirmPassword.centerXAnchor.constraint(equalTo: self.view.centerXAnchor, constant: 0),
          //  confirmPassword.centerYAnchor.constraint(equalTo: self.view.centerYAnchor, constant: -12),//50
            confirmPassword.widthAnchor.constraint(equalTo: self.view.widthAnchor, constant: -60),
            confirmPassword.heightAnchor.constraint(equalToConstant: 40),
            
            // Button
            
            continueBtn.centerXAnchor.constraint(equalTo: self.view.centerXAnchor, constant: 0),
            continueBtn.widthAnchor.constraint(equalTo: self.view.widthAnchor, constant: -60),
            continueBtn.heightAnchor.constraint(equalToConstant: 40)
        ]
        
        
        /// Creating these anchors with reference because we need to animate them
        confirmPassAnchor = confirmPassword.centerYAnchor.constraint(equalTo: self.view.centerYAnchor, constant: -12)//110
        confirmPassAnchor?.isActive = true
        
        continueBtnAnchor =  continueBtn.centerYAnchor.constraint(equalTo: self.view.centerYAnchor, constant: 50)//110
        continueBtnAnchor?.isActive = true
        
        NSLayoutConstraint.activate(constraints)
    }
    
}
