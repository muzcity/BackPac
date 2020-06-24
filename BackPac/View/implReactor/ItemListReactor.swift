//
//  ItemListReactor.swift
//  BackPac
//
//  Created by roy2020 on 2020/06/21.
//  Copyright © 2020 muzcity. All rights reserved.
//

import Foundation
import RxSwift
import RxCocoa

/// 리스트 화면에서의 유저의 리액션을 담당하는 클래스
class ItemListReactor {
    
    init(reducer:Reducer, targetViewController:UIViewController) {
        
        self.reducer = reducer as? ItemListReducer
        self.ownerViewController =  targetViewController
    }
    
    
    private var reducer : ItemListReducer?
    private var ownerViewController : UIViewController?
}

extension ItemListReactor {
    
    func clickItem(at index: Int) {
        let vc = DetailViewController(nibName: nil, bundle: nil)
        let vm = reducer?.viewModel()?.object(at: index)
        vc.reducer = ItemDetailReducer(viewModel: vm)
        ownerViewController?.navigationController?.pushViewController(vc, animated: true)
    }
    
}
