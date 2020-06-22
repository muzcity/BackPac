//
//  ItemDetailReactor.swift
//  BackPac
//
//  Created by roy2020 on 2020/06/21.
//  Copyright © 2020 muzcity. All rights reserved.
//

import UIKit


class ItemDetailReactor {
    
    init(reducer:Reducer, targetViewController:UIViewController) {
        
        self.reducer = reducer as? ItemDetailReducer
        self.ownerViewController =  targetViewController
    }
    
    private var reducer : ItemDetailReducer?
    private var ownerViewController : UIViewController?
}

extension ItemDetailReactor {
    
    func clickShowWeb() {
        
        guard let vm = reducer?.viewModel() else {
            return
        }
        
        if let url = URL(string: vm.trackViewUrl) {
            UIApplication.shared.open(url, options: [:], completionHandler: nil)
        }
    }
    
    func clickShowShare() {
        
        guard let vm = reducer?.viewModel() else {
            return
        }
        
        if let url = URL(string: vm.trackViewUrl) {
            let items = [url]
            let ac = UIActivityViewController(activityItems: items, applicationActivities: nil)
            ownerViewController?.present(ac, animated: true)
        }
        
    }
    
    func clickFoldOrExpand() {
        guard let reducer = reducer else {
            return
        }
        
        reducer.fold = !reducer.fold
    }
    
}
