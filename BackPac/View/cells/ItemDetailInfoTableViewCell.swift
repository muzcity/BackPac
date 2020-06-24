//
//  ItemDetailInfoTableViewCell.swift
//  BackPac
//
//  Created by roy2020 on 2020/06/21.
//  Copyright © 2020 muzcity. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa

class ItemDetailInfoTableViewCell: UITableViewCell {

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        createViews()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        
    }

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
        createViews()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

    var clickShareHandler : VOID_HANDLER = nil
    var clickShowWebHandler : VOID_HANDLER = nil
    
    private var productLabel : UILabel!
    private var sellerLabel : UILabel!
    private var formattedPrice : UILabel!
    
    private var disposeBag : DisposeBag! = DisposeBag()
    
    static let CELL_HEIGHT: CGFloat = 170
}

extension ItemDetailInfoTableViewCell {
    func setCell(_ vm : ItemDetailViewModel) {
        
        productLabel.text = vm.trackName
        sellerLabel.text = vm.sellerName
        formattedPrice.text = vm.formattedPrice
        
    }
}

extension ItemDetailInfoTableViewCell {
    
    private func createViews() {
        
        selectionStyle = .none
        
        let primary = UILabel(frame: .zero)
        primary.font = UIFont.boldSystemFont(ofSize: 24)
        productLabel = primary
        
        let secondary = UILabel(frame: .zero)
        secondary.font = UIFont.systemFont(ofSize: 14)
        sellerLabel = secondary
        
        let tertiary = UILabel(frame: .zero)
        tertiary.font = UIFont.boldSystemFont(ofSize: 24)
        formattedPrice = tertiary
        
        contentView.addSubview(primary)
        contentView.addSubview(secondary)
        contentView.addSubview(tertiary)
        
        primary.translatesAutoresizingMaskIntoConstraints = false
        secondary.translatesAutoresizingMaskIntoConstraints = false
        tertiary.translatesAutoresizingMaskIntoConstraints = false
        
        contentView.addConstraints(
            NSLayoutConstraint.constraints(withVisualFormat: "H:|-8-[primary]-8-|", options: NSLayoutConstraint.FormatOptions.init(rawValue: 0), metrics: nil, views: ["primary":primary])
        )
        contentView.addConstraints(
            NSLayoutConstraint.constraints(withVisualFormat: "H:|-8-[secondary]-8-|", options: NSLayoutConstraint.FormatOptions.init(rawValue: 0), metrics: nil, views: ["secondary":secondary])
        )
        contentView.addConstraints(
            NSLayoutConstraint.constraints(withVisualFormat: "H:|-8-[tertiary]-8-|", options: NSLayoutConstraint.FormatOptions.init(rawValue: 0), metrics: nil, views: ["tertiary":tertiary])
        )
        
        contentView.addConstraints(
            NSLayoutConstraint.constraints(withVisualFormat: "V:|-8-[primary]-4-[secondary]-8-[tertiary]", options: NSLayoutConstraint.FormatOptions.init(rawValue: 0), metrics: nil, views: ["primary":primary, "secondary":secondary, "tertiary":tertiary])
        )
        
        
        
        //웹에서 보기 | 공유하기
        let buttonView = UIView(frame: .zero)
        contentView.addSubview(buttonView)
        buttonView.clipsToBounds = true
        buttonView.backgroundColor = .lightGray
        buttonView.borderColor = UIColor.lightGray.cgColor
        buttonView.borderW = 1
        buttonView.cornerR = 4
        
        let line = UIView.line()
        contentView.addSubview(line)
        
        buttonView.translatesAutoresizingMaskIntoConstraints = false
        line.fillHorizontalLayout(margin: 8)
        
        contentView.addConstraints(
            NSLayoutConstraint.constraints(withVisualFormat: "H:|-8-[buttonView]-8-|", options: NSLayoutConstraint.FormatOptions.init(rawValue: 0), metrics: nil, views: ["buttonView":buttonView])
        )
        contentView.addConstraints(
            NSLayoutConstraint.constraints(withVisualFormat: "V:[buttonView(44)]-8-[line(1)]|", options: NSLayoutConstraint.FormatOptions.init(rawValue: 0), metrics: nil, views: ["buttonView":buttonView, "line":line])
        )
                
        createButtons(buttonView)
        
    }
    
    private func createButtons(_ parentView: UIView) {
        
        let leftButton = UIButton(type: .custom)
        leftButton.backgroundColor = .white
        leftButton.setTitle("웹에서 보기", for: .normal)
        leftButton.setTitleColor(.gray5, for: .normal)
        leftButton.titleLabel?.font = UIFont.systemFont(ofSize: 14)
        leftButton.setTitleColor(.black, for: .normal)
        
        let rightButton = UIButton(type: .custom)
        rightButton.backgroundColor = .white
        rightButton.setTitle("공유하기", for: .normal)
        rightButton.setTitleColor(.gray5, for: .normal)
        rightButton.titleLabel?.font = UIFont.systemFont(ofSize: 14)
        rightButton.setTitleColor(.black, for: .normal)
        
        parentView.addSubview(leftButton)
        parentView.addSubview(rightButton)
        
        leftButton.translatesAutoresizingMaskIntoConstraints = false
        rightButton.translatesAutoresizingMaskIntoConstraints = false
        
        parentView.addConstraints(
            NSLayoutConstraint.constraints(withVisualFormat: "H:|-1-[leftButton(rightButton)]-1-[rightButton]-1-|", options: NSLayoutConstraint.FormatOptions.init(rawValue: 0), metrics: nil, views: ["leftButton":leftButton, "rightButton":rightButton])
        )
        parentView.addConstraints(
            NSLayoutConstraint.constraints(withVisualFormat: "V:|-1-[leftButton]-1-|", options: NSLayoutConstraint.FormatOptions.init(rawValue: 0), metrics: nil, views: ["leftButton":leftButton, "rightButton":rightButton])
        )
        parentView.addConstraints(
            NSLayoutConstraint.constraints(withVisualFormat: "V:|-1-[rightButton]-1-|", options: NSLayoutConstraint.FormatOptions.init(rawValue: 0), metrics: nil, views: ["leftButton":leftButton, "rightButton":rightButton])
        )
        
        
        leftButton.rx.tap.subscribe(onNext: { [weak self] () in
            self?.clickShowWebHandler?()
        }).disposed(by: disposeBag)
        
        rightButton.rx.tap.subscribe(onNext: { [weak self] () in
            self?.clickShareHandler?()
        }).disposed(by: disposeBag)
    }
}
