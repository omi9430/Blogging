//
//  InAppPurchasesSubView.swift
//  Bloggers
//
//  Created by omair khan on 15/02/2022.
//

import UIKit

class IAPHeaderView: UIView {

    private let imageView :  UIImageView = {
       
        var imageView = UIImageView()
        imageView.image = UIImage(systemName: "crown.fill")
        imageView.contentMode = .scaleToFill
      
        imageView.tintColor = .white
      //  imageView.translatesAutoresizingMaskIntoConstraints = false
        return  imageView
    }()
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        self.clipsToBounds = true
        self.addSubview(imageView)
        self.backgroundColor = .purple
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        imageView.frame = CGRect(x: 0, y: 0, width: self.frame.width/3, height: self.frame.width/3)
        imageView.center = self.center
       
    }
    

}
