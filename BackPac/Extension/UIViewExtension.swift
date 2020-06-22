//
//  UIViewExtension.swift
//  BackPac
//
//  Created by roy2020 on 2020/06/20.
//  Copyright © 2020 muzcity. All rights reserved.
//

import UIKit

extension UIView {
    
    var cornerR : CGFloat {
        get {
            return self.layer.cornerRadius
        }
        
        set {
            self.layer.cornerRadius = newValue
        }
    }
    
    var borderW : CGFloat {
        get {
            return self.layer.borderWidth
        }
        
        set {
            self.layer.borderWidth = newValue
        }
    }
    
    var borderColor : CGColor? {
        get {
            return self.layer.borderColor
        }
        
        set {
            layer.borderColor = newValue
        }
    }
    
    public func fillLayout() {
        
        guard let superView = self.superview else {
            return
        }
        
        self.translatesAutoresizingMaskIntoConstraints = false
        
        self.leftAnchor.constraint(equalTo: superView.leftAnchor, constant: 0).isActive = true
        self.rightAnchor.constraint(equalTo: superView.rightAnchor, constant: 0).isActive = true
        self.topAnchor.constraint(equalTo: superView.topAnchor, constant: 0).isActive = true
        self.bottomAnchor.constraint(equalTo: superView.bottomAnchor, constant: 0).isActive = true
    }
    
    public func fillHorizontalLayout(margin : CGFloat = 0) {
        guard let superView = self.superview else {
            return
        }
        
        self.translatesAutoresizingMaskIntoConstraints = false
        
        self.leftAnchor.constraint(equalTo: superView.leftAnchor, constant: margin).isActive = true
        self.rightAnchor.constraint(equalTo: superView.rightAnchor, constant: -margin).isActive = true
    }
    
    public func fillVerticalLayout(margin : CGFloat = 0) {
        guard let superView = self.superview else {
            return
        }
        
        self.translatesAutoresizingMaskIntoConstraints = false
        
        self.topAnchor.constraint(equalTo: superView.topAnchor, constant: margin).isActive = true
        self.bottomAnchor.constraint(equalTo: superView.bottomAnchor, constant: -margin).isActive = true
    }
    
    static func line() -> UIView {
        let v = UIView(frame:.zero)
        v.backgroundColor = UIColor.lightgray1
        return v
    }
}
