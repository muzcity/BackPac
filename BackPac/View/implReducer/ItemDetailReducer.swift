//
//  ItemDetailReducer.swift
//  BackPac
//
//  Created by roy2020 on 2020/06/21.
//  Copyright © 2020 muzcity. All rights reserved.
//

import Foundation

class ItemDetailReducer : Reducer {
    
    init(viewModel : ItemDetailViewModel?) {
        super.init()
        
        self.model = viewModel
    }
    
    func viewModel() -> ItemDetailViewModel? {
        return model as? ItemDetailViewModel
    }
    
    
    //화면 정보 갱신에 대한 변수 fold여부
    var fold : Bool = true {
        didSet {
            status.accept(.patch)
        }
    }
}

extension ItemDetailReducer {
    
    
}
