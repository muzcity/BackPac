//
//  UICollectionViewCell.swift
//  BackPac
//
//  Created by roy2020 on 2020/06/22.
//  Copyright © 2020 muzcity. All rights reserved.
//

import UIKit

extension UICollectionViewCell {
    
    public static func cellName() -> String {
        
        let className = NSStringFromClass(self)
        if let cellName = className.components(separatedBy: ".").last {
            return cellName
        }
        
        return "UICollectionViewCell"
    }
    
}
