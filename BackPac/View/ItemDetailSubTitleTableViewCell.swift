//
//  ItemDetailSubTitleTableViewCell.swift
//  BackPac
//
//  Created by roy2020 on 2020/06/21.
//  Copyright © 2020 muzcity. All rights reserved.
//

import UIKit

class ItemDetailSubTitleTableViewCell: UITableViewCell {

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

    private var leftLabel : UILabel!
    private var rightLabel : UILabel!
    
    static let CELL_HEIGHT: CGFloat = 44
}


extension ItemDetailSubTitleTableViewCell {
    
    func setCell(title: String, subTitle:String) {
        leftLabel.text = title
        rightLabel.text = subTitle
    }
    
}

extension ItemDetailSubTitleTableViewCell {
    private func createViews() {
        selectionStyle = .none
        
        let label1 = UILabel(frame: .zero)
        label1.font = UIFont.systemFont(ofSize: 14)
        leftLabel = label1
        
        
        let label2 = UILabel(frame: .zero)
        label2.font = UIFont.systemFont(ofSize: 14)
        label2.textAlignment = .right
        label2.textColor = .mint3
        rightLabel = label2
        
        let line = UIView.line()
        
        
        
        contentView.addSubview(label1)
        contentView.addSubview(label2)
        contentView.addSubview(line)
        
        label1.translatesAutoresizingMaskIntoConstraints = false
        label2.translatesAutoresizingMaskIntoConstraints = false
        
        line.fillHorizontalLayout(margin: 8)
        
        contentView.addConstraints(
            NSLayoutConstraint.constraints(withVisualFormat: "H:|-8-[label1(label2)][label2]-38-|", options: NSLayoutConstraint.FormatOptions.init(rawValue: 0), metrics: nil, views: ["label1":label1,"label2":label2])
        )
        
        contentView.addConstraints(
            NSLayoutConstraint.constraints(withVisualFormat: "V:|[label1][line(1)]|", options: NSLayoutConstraint.FormatOptions.init(rawValue: 0), metrics: nil, views: ["label1":label1,"label2":label2, "line":line])
        )
        
        contentView.addConstraints(
            NSLayoutConstraint.constraints(withVisualFormat: "V:|[label2][line]|", options: NSLayoutConstraint.FormatOptions.init(rawValue: 0), metrics: nil, views: ["label1":label1,"label2":label2, "line":line])
        )
    }
}
