//
//  MainViewController.swift
//  BackPac
//
//  Created by roy2020 on 2020/06/20.
//  Copyright © 2020 muzcity. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa

class MainViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        setupUI()
        setupReducer()
    }
    
    private var table : UITableView! = {
        let tb = UITableView(frame: .zero)
        return tb
    }()
        
    private var disposeBag : DisposeBag! = DisposeBag()
    
    private var reducer : ItemListReducer!
    private var reactor : ItemListReactor?
}

/// MARK: - custom ( public )
extension MainViewController {
    
}

/// MARK: - custom ( private )
extension MainViewController {
    
    private func setupUI() {
        
        if #available(iOS 11.0, *) {
            navigationController?.navigationBar.prefersLargeTitles = true
        } else {
            // Fallback on earlier versions
        }
        
        view.addSubview(table)
        table.dataSource = self
        table.delegate = self
        
        table.fillLayout()
        
        table.register(MainTableViewCell.self, forCellReuseIdentifier: MainTableViewCell.cellName())
        
        table.rx.itemSelected.subscribe(onNext: { [weak self] (indexPath) in
            self?.reactor?.clickItem(at: indexPath.row)
        }).disposed(by: disposeBag)
    }
    
    private func setupReducer() {
        
        reducer = ItemListReducer(keyword: "핸드메이드")
        reactor = ItemListReactor(reducer: reducer, targetViewController: self)
        
        reducer.status.subscribe(onNext: { [weak self] (status) in
        
            guard let self = self else {
                return
            }
            
            switch status {
            case .request:
                self.title = self.reducer.searchKeyword
                UIApplication.shared.isNetworkActivityIndicatorVisible = true
            case .responded:
                UIApplication.shared.isNetworkActivityIndicatorVisible = false
            case .respondedError:
                UIApplication.shared.isNetworkActivityIndicatorVisible = false
                ShowAlert(self, title: "Error", message: "에러가 발생했습니다. 잠시후에 다시 시도해주세요.", cancelTitle: nil, cancelHandler: nil, okHandler: nil)
            case .update:
                self.table.reloadData()
            default:
                break
            }
            
        }).disposed(by: disposeBag)
        
    }
}

/// MARK: - tableview..
extension MainViewController : UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return reducer.viewModel()?.count ?? 0
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: MainTableViewCell.cellName(), for: indexPath)
        
        if let mainCell = cell as? MainTableViewCell {
            let vm = reducer.viewModel()?.object(at: indexPath.row)
            mainCell.setCell(vm)
        }
        
        return cell
    }

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return MainTableViewCell.MAINTABLEVIEWCELL_HEIGHT
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 4
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        return UIView(frame: .zero)
    }
    
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 4
    }
    
    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        return UIView(frame: .zero)
    }
    
}
