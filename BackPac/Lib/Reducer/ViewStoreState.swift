//
//  ViewStoreState.swift
//  BackPac
//
//  Created by roy2020 on 2020/06/21.
//  Copyright © 2020 muzcity. All rights reserved.
//

import Foundation

enum ViewStoreState {
    case create
    case request
    case responded
    case respondedError
    case update
    case customUpdate(ViewStoreSubStateProtocol)
    case patch
    case customPatch(ViewStoreSubStateProtocol)
    case reuse
    case destroy
}
