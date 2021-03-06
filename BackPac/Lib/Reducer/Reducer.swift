//
//  Reducer.swift
//  BackPac
//
//  Created by roy2020 on 2020/06/21.
//  Copyright © 2020 muzcity. All rights reserved.
//

import Foundation
import RxSwift
import RxCocoa



protocol ReducerBaseProtocol {
    var status : BehaviorRelay<ViewStoreState> { get }
    var model : ReducerDataModelProtocol? { get }
    
    func trans<T>(_ type : T.Type) -> T?
}


extension ReducerBaseProtocol {
    func trans<T>(_ type: T.Type) -> T? {
        return model as? T
    }
}



/// status를 이용한 뷰의 업데이트 상태값을 관리
class Reducer : ReducerBaseProtocol {
    
    var status: BehaviorRelay<ViewStoreState> = BehaviorRelay.init(value: .create)
    var disposeBag : DisposeBag! = DisposeBag()
    var model: ReducerDataModelProtocol?
    
}
