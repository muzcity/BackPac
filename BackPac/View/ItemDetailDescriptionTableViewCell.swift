//
//  ItemDetailDescriptionTableViewCell.swift
//  BackPac
//
//  Created by roy2020 on 2020/06/22.
//  Copyright © 2020 muzcity. All rights reserved.
//

import UIKit

class ItemDetailDescriptionTableViewCell: UITableViewCell {
    
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
    
    private var descriptionLabel : UILabel!
}


extension ItemDetailDescriptionTableViewCell {
    
    func setCell(_ vm : ItemDetailViewModel) {
        descriptionLabel.text = vm.description
    }
    
}

extension ItemDetailDescriptionTableViewCell {
    private func createViews() {
        selectionStyle = .none
        
        let label = UILabel(frame: .zero)
        label.font = UIFont.systemFont(ofSize: 14)
        label.textAlignment = .center
        descriptionLabel = label
        
        contentView.addSubview(label)
        
        label.numberOfLines = 10
        
        label.fillHorizontalLayout(margin: 8)
        label.fillVerticalLayout(margin: 8)
        
    }
}
