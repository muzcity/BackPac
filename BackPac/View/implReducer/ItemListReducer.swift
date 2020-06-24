//
//  ItemListReducer.swift
//  BackPac
//
//  Created by roy2020 on 2020/06/21.
//  Copyright © 2020 muzcity. All rights reserved.
//

import Foundation
import RxSwift
import RxCocoa

/// reducer 구현체 vm모델과 리스트 화면의 상태값들을 관리한다
class ItemListReducer : Reducer {
    
    func viewModel() -> ItemViewModel? {
        return model as? ItemViewModel
    }
    
    init(keyword : String) {
        self.keyword = keyword
        
        super.init()
        
        self.requestList(by: keyword)
    }
    
    private var keyword : String
    var searchKeyword:String {
        return keyword
    }
    
    override var model: ReducerDataModelProtocol? {
        didSet {
            status.accept(.update)
        }
    }
}

extension ItemListReducer {
    
    private func requestList(by keyword:String) {
        
        status.accept(.request)
        
        let ob = NetworkManager.shared.request(by: keyword)
        ob.subscribe(onNext: { [weak self] (result) in
            
            guard let self = self else {
                return
            }
            
            switch result {
            case .success(let data) :
                let model = try? JSONDecoder().decode(ItemModel.self, from: data)
                
                guard let mo = model else {
                    self.status.accept(.respondedError)
                    return
                }

                self.status.accept(.responded)
                self.model = ItemViewModel(model: mo)

            case .failure(_) :
                // error message 노출.
                // 데이터 파싱 오류 또는 라이브러리 오류
                self.status.accept(.respondedError)
                
            }
            
        }, onError: { [weak self] (error) in
            // api 호출 실패
            self?.status.accept(.respondedError)
        }, onCompleted: {
            
        }) {
            
        }.disposed(by: disposeBag)
        
    }
}


