//
//  ViewStoreSubState.swift
//  BackPac
//
//  Created by roy2020 on 2020/06/21.
//  Copyright © 2020 muzcity. All rights reserved.
//

import Foundation

protocol ViewStoreSubStateProtocol {}

enum ViewStoreSubStateForItemDetail : ViewStoreSubStateProtocol {
    typealias RawValue = UInt
    
    case fold
    case expand
}
