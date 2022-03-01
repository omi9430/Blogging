//
//  IAPDescritpion.swift
//  Bloggers
//
//  Created by omair khan on 15/02/2022.
//

import UIKit

class IAPDescritpion: UIView {

  private  let headingLabel : UILabel = {
        
        var label = UILabel()
        label.text = "Join Bloggers Premium to read unlimited articles"
        label.font = .systemFont(ofSize: 22, weight: .medium)
        label.numberOfLines = 0
        label.textAlignment = .center
        label.translatesAutoresizingMaskIntoConstraints = false
        
        return  label
    }()
    
   private let priceLabel : UILabel = {
        
        var label = UILabel()
        label.text = "$4.99"
        label.font = .systemFont(ofSize: 22, weight: .thin)
        label.numberOfLines = 0
        label.textAlignment = .center
        label.translatesAutoresizingMaskIntoConstraints = false
        
        return  label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        self.addSubview(headingLabel)
        self.addSubview(priceLabel)
        self.backgroundColor = .yellow
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        
        // Adding constraints
        
        self.headingLabel.centerYAnchor.constraint(equalTo: self.centerYAnchor, constant: -50).isActive = true
        self.headingLabel.centerXAnchor.constraint(equalTo: self.centerXAnchor, constant: 0).isActive = true
        self.headingLabel.widthAnchor.constraint(equalTo: self.widthAnchor, constant: -20).isActive = true
        
        self.priceLabel.centerYAnchor.constraint(equalTo: self.centerYAnchor, constant: 10).isActive = true
        self.priceLabel.centerXAnchor.constraint(equalTo: self.centerXAnchor, constant: 0).isActive = true
    }
    
}
