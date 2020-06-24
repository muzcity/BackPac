//
//  ItemDetailFoldTableViewCell.swift
//  BackPac
//
//  Created by roy2020 on 2020/06/22.
//  Copyright © 2020 muzcity. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa

class ItemDetailFoldTableViewCell: UITableViewCell {
    
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
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        contentView.layoutIfNeeded()
    }
    
    
    
    var clickHandler : VOID_HANDLER = nil
    
    private var stack : UIStackView!
    private var primaryLabel : UILabel!
    private var secondaryLabel : UILabel!
    private var arrowButton : UIButton!
    private var releaseNotesLabel : UILabel!
    
    private var disposeBag : DisposeBag! = DisposeBag()
    
    private var isFold : Bool = true {
        didSet {
            
            stack.arrangedSubviews[1].isHidden = isFold
            
            if isFold {
                arrowButton.setImage(UIImage(named: "item_detail_arrow_down"), for: .normal)

            }
            else {
                arrowButton.setImage(UIImage(named: "item_detail_arrow_up"), for: .normal)

            }
        }
    }
    
    static let CELL_HEIGHT: CGFloat = 44
}


extension ItemDetailFoldTableViewCell {
    
    func setCell(title: String, subTitle:String, releaseNotes:String, isFold:Bool) {
        primaryLabel.text = title
        secondaryLabel.text = subTitle
        arrowButton.isHidden = releaseNotes.isEmpty
        releaseNotesLabel.text = releaseNotes
        
        self.isFold = isFold
    }
    
}

extension ItemDetailFoldTableViewCell {
    private func createViews() {

        selectionStyle = .none

        let stackView = UIStackView(frame: .zero)
        stackView.axis = .vertical
        stackView.distribution = .fill
        stackView.alignment = .fill
        stackView.spacing = 0

        stack = stackView

        contentView.addSubview(stack)

        stackView.fillLayout()
        stackView.widthAnchor.constraint(equalToConstant: UIScreen.main.bounds.size.width).isActive = true

        let view = UIView(frame: .zero)

        let notesView = UIView(frame: .zero)
        notesView.backgroundColor = .white

        stack.addArrangedSubview(view)
        stack.addArrangedSubview(notesView)

        view.translatesAutoresizingMaskIntoConstraints = false
        notesView.translatesAutoresizingMaskIntoConstraints = false
        
        view.fillHorizontalLayout()
        view.heightAnchor.constraint(equalToConstant: ItemDetailFoldTableViewCell.CELL_HEIGHT).isActive = true
        notesView.fillHorizontalLayout()

        createInfoView(view)
        createFoldView(notesView)
    }

    private func createInfoView(_ parentView : UIView) {

        let left = UILabel(frame: .zero)
        left.font = UIFont.systemFont(ofSize: 14)
        let right = UILabel(frame: .zero)
        right.font = UIFont.systemFont(ofSize: 14)
        right.textColor = .mint3
        right.textAlignment = .right
        let button = UIButton(type: .custom)

        button.setImage(UIImage(named: "item_detail_arrow_down"), for: .normal)

        let line = UIView.line()
        
        primaryLabel = left
        secondaryLabel = right
        arrowButton = button


        parentView.addSubview(left)
        parentView.addSubview(secondaryLabel)
        parentView.addSubview(arrowButton)
        parentView.addSubview(line)

        
        left.fillVerticalLayout()
        right.fillVerticalLayout()
        button.fillVerticalLayout()
        line.fillHorizontalLayout(margin: 8)
        line.heightAnchor.constraint(equalToConstant: 1).isActive = true
        line.bottomAnchor.constraint(equalTo: parentView.bottomAnchor, constant: 0).isActive = true

        parentView.addConstraints(
            NSLayoutConstraint.constraints(withVisualFormat: "H:|-8-[left(right)][right][button(30)]-8-|", options: NSLayoutConstraint.FormatOptions.init(rawValue: 0), metrics: nil, views: ["left":left,"right":right,"button":button])
        )

        button.rx.tap.subscribe(onNext: {[weak self] () in
            self?.clickHandler?()
        }).disposed(by: disposeBag)

    }
    
    private func createFoldView(_ parentView : UIView) {
        let backView = UIView(frame: .zero)
        backView.backgroundColor = .lightgray2
        parentView.addSubview(backView)
        
        backView.fillHorizontalLayout(margin: 8)
        backView.fillVerticalLayout()
        
        let label3 = UILabel(frame: .zero)
        label3.font = UIFont.systemFont(ofSize: 14)
        label3.textColor = .gray3
        label3.backgroundColor = .clear
        label3.numberOfLines = 0
        releaseNotesLabel = label3

        backView.addSubview(label3)
        label3.fillHorizontalLayout(margin: 8)
        
        backView.addConstraints(
            NSLayoutConstraint.constraints(withVisualFormat: "V:|-8@750-[label3]-8@750-|", options: NSLayoutConstraint.FormatOptions.init(rawValue: 0), metrics: nil, views: ["label3":label3])
        )
        
    }
}
