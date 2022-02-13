//
//  LaunchViewController.swift
//  Bloggers
//
//  Created by omair khan on 08/02/2022.
//

import UIKit

class LaunchViewController: UIViewController {
    
    /**
     - Title Label
     - Image View
     */
    
    let titleLabel : UILabel = {
        
        var lbl = UILabel()
        lbl.font = UIFont(name: "Thonburi-Bold", size: 30)
        lbl.text = "Welcome!"
        lbl.textAlignment = .center
        lbl.translatesAutoresizingMaskIntoConstraints = false
        return lbl
    }()
    
    
    var imageView : UIImageView = {
       
        var imageView = UIImageView(frame: CGRect(x: 0, y: 0, width: 150, height: 150))
        imageView.contentMode  = .center
        imageView.contentMode = .scaleAspectFit
        imageView.image = UIImage(named: "logo")
        
        //imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()

    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        //titleLabel.alpha = 0
        titleLabel.isHidden = true
        imageView.alpha = 1
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        titleLabelAnimation()
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        self.view.backgroundColor = .white

        setUpViews()
    }
    
    override func viewDidLayoutSubviews() {
        self.imageView.center = self.view.center
        DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
            self.titleLabel.alpha = 0
            self.imageAnimation()
        }
        
    }
    
    
    func setUpViews(){
        
        
        /**
         - Add Subviews
         - Set Constraints
         */
        self.view.addSubview(imageView)
        self.view.addSubview(titleLabel)
      
        
        let constraints = [
            
//            imageView.centerXAnchor.constraint(equalTo: self.view.centerXAnchor, constant: 0),
//            imageView.centerYAnchor.constraint(equalTo: self.view.centerYAnchor, constant: 0),
            imageView.heightAnchor.constraint(equalToConstant: 150),
            imageView.widthAnchor.constraint(equalToConstant: 150),
            
            titleLabel.centerXAnchor.constraint(equalTo: self.view.centerXAnchor, constant: 0),
            titleLabel.centerYAnchor.constraint(equalTo: self.view.centerYAnchor, constant: -100),
            titleLabel.widthAnchor.constraint(equalToConstant: 170)
        
        ]
        
        NSLayoutConstraint.activate(constraints)
        
    }
    
    
    //MARK: Animations
    

    //Title Animation
    func titleLabelAnimation(){
        
        UIView.animate(withDuration: 1, delay: 0.5, usingSpringWithDamping: 0.1, initialSpringVelocity: 0.5, options: [], animations: {
            
            self.titleLabel.isHidden = false
            self.titleLabel.center.y -= 50
            
        })
    }
    
    // Image Animation
    
    func imageAnimation() {
        
        /**
         - Animate ImageView
         - Perform Segue to Tab Bar Controller with a delay
         */
        
        UIView.animate(withDuration: 0.5) {
            
            //Animating size for imageView
            let size = self.view.frame.size.width * 7
            let diffX = size - self.view.frame.size.width
            let diffY = self.view.frame.size.height - size



            self.imageView.frame = CGRect(x:  -(diffX/2) ,
                                          y: diffY/2,
                                          width: size,
                                          height: size)
            
            self.imageView.alpha = 0
            
            
        } completion: { done in
            if done {
                
                // Presenting ViewController
                DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                    
                    
                    let vc = AuthenticationViewController()
                    vc.modalPresentationStyle = .fullScreen
                    vc.modalTransitionStyle = .crossDissolve
                    self.present(vc, animated: true, completion: nil)
                }
                
            }
        }


    }
    
    
    
    

}
