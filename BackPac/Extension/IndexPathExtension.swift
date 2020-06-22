//
//  IndexPathExtension.swift
//  BackPac
//
//  Created by roy2020 on 2020/06/22.
//  Copyright © 2020 muzcity. All rights reserved.
//

import Foundation

extension IndexPath {
    
    func compare(_ section : Int , _ row : Int) -> Bool {
        return (self.section == section && self.row == row)
    }
        
}
