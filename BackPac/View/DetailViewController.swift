//
//  DetailViewController.swift
//  BackPac
//
//  Created by roy2020 on 2020/06/20.
//  Copyright © 2020 muzcity. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa

class DetailViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        setupUI()
        setupReducer()
    }
    
    private var table : UITableView! = {
        let tb = UITableView(frame: .zero, style: .grouped)
        tb.separatorStyle = .none
        return tb
    }()
        
    private var disposeBag : DisposeBag! = DisposeBag()
    
    var reducer : ItemDetailReducer!
    var reactor : ItemDetailReactor?
    
    let SECTION_HEADER_HEIGHT : CGFloat = 0.1
    let SECTION_FOOTER_HEIGHT : CGFloat = 10
    let ESTIMATED_ROW_HEIGHT : CGFloat = 44
}

///MARK: - custom (public)
extension DetailViewController {
    
}


///MARK: - custom (private)
extension DetailViewController {
    
    private func setupUI() {
        
        if #available(iOS 11.0, *) {
            navigationItem.largeTitleDisplayMode = .never
        } else {
            // Fallback on earlier versions
        }
        
        view.addSubview(table)
        table.dataSource = self
        table.delegate = self
        
        table.fillLayout()
        
        table.sectionHeaderHeight = SECTION_HEADER_HEIGHT
        table.sectionFooterHeight = SECTION_FOOTER_HEIGHT
        table.estimatedRowHeight = ESTIMATED_ROW_HEIGHT
        
        table.register(ItemDetailScreenShotTableViewCell.self, forCellReuseIdentifier: ItemDetailScreenShotTableViewCell.cellName())
        table.register(ItemDetailInfoTableViewCell.self, forCellReuseIdentifier: ItemDetailInfoTableViewCell.cellName())
        table.register(ItemDetailSubTitleTableViewCell.self, forCellReuseIdentifier: ItemDetailSubTitleTableViewCell.cellName())
        table.register(ItemDetailFoldTableViewCell.self, forCellReuseIdentifier: ItemDetailFoldTableViewCell.cellName())
        table.register(ItemDetailDescriptionTableViewCell.self, forCellReuseIdentifier: ItemDetailDescriptionTableViewCell.cellName())
        table.register(ItemDetailTagTableViewCell.self, forCellReuseIdentifier: ItemDetailTagTableViewCell.cellName())
        
        
    }
    
    private func setupReducer() {

        reactor = ItemDetailReactor(reducer: reducer, targetViewController: self)
        
        reducer.status.subscribe(onNext: { [weak self] (status) in
        
            guard let self = self else {
                return
            }
            
            switch status {
            case .patch:
                self.table.beginUpdates()
                self.table.reloadRows(at: [IndexPath(row: 4, section: 0)], with: UITableView.RowAnimation.automatic)
                self.table.endUpdates()
            default:
                break
            }
            
        }).disposed(by: disposeBag)
        
    }
    
    private func cellName(indexPath: IndexPath) -> String {
        guard indexPath.section == 0 else {
            return ItemDetailTagTableViewCell.cellName()
        }
        
        switch indexPath.row {
        case 0:
            return ItemDetailScreenShotTableViewCell.cellName()
        case 1:
            return ItemDetailInfoTableViewCell.cellName()
        case 2:
            return ItemDetailSubTitleTableViewCell.cellName()
        case 3:
            return ItemDetailSubTitleTableViewCell.cellName()
        case 4:
            return ItemDetailFoldTableViewCell.cellName()
        case 5:
            return ItemDetailDescriptionTableViewCell.cellName()
        default:
            return ""
        }
    }
}

extension DetailViewController : UITableViewDataSource, UITableViewDelegate {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return section == 0 ? 6 : 1
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return SECTION_HEADER_HEIGHT
    }

    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return SECTION_FOOTER_HEIGHT
    }

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {

        if indexPath.compare(0, 0) {
            return ItemDetailScreenShotTableViewCell.CELL_HEIGHT
        }

        if indexPath.compare(0, 1) {
            return ItemDetailInfoTableViewCell.CELL_HEIGHT
        }

        if indexPath.compare(0, 2) {
            return ItemDetailSubTitleTableViewCell.CELL_HEIGHT
        }

        if indexPath.compare(0, 3) {
            return ItemDetailSubTitleTableViewCell.CELL_HEIGHT
        }

        if indexPath.compare(0, 4) {
            return reducer.fold ? ItemDetailFoldTableViewCell.CELL_HEIGHT : UITableView.automaticDimension
        }

        return UITableView.automaticDimension
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: cellName(indexPath: indexPath), for: indexPath)
    
        guard let vm = reducer.viewModel() else {
            return cell
        }
        
        if let screenShotCell = cell as? ItemDetailScreenShotTableViewCell {
            screenShotCell.setCell(vm)
        }
        
        if let infoCell = cell as? ItemDetailInfoTableViewCell {
            infoCell.setCell(vm)
            
            infoCell.clickShowWebHandler = reactor?.clickShowWeb
            infoCell.clickShareHandler = reactor?.clickShowShare
        }
        
        if let subTitleCell = cell as? ItemDetailSubTitleTableViewCell {
            if indexPath.compare(0, 2) {
                subTitleCell.setCell(title: "크기", subTitle: vm.fileSizeBytes)
            }
            if indexPath.compare(0, 3) {
                subTitleCell.setCell(title: "연령", subTitle: vm.contentAdvisoryRating)
            }
        }
        
        if let foldCell = cell as? ItemDetailFoldTableViewCell {
            foldCell.setCell(title: "새로운 기능", subTitle: vm.version, releaseNotes: vm.releaseNotes, isFold: reducer.fold)
            foldCell.clickHandler = reactor?.clickFoldOrExpand
        }
        
        if let descCell = cell as? ItemDetailDescriptionTableViewCell {
            descCell.setCell(vm)
        }
        
        if let tagCell = cell as? ItemDetailTagTableViewCell {
            tagCell.setCell(vm)
        }
        
        return cell
    }
    
}
