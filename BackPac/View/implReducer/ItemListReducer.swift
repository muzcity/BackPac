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

class ItemListReducer : Reducer {
    
    func viewModel() -> ItemViewModel? {
        guard let mo = model as? ItemModel else {
            return nil
        }
        
        let vmo = ItemViewModel(model: mo)
        return vmo
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
                
                self.model = mo
                self.status.accept(.responded)

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


