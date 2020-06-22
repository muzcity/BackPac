//
//  ItemDetailTagTableViewCell.swift
//  BackPac
//
//  Created by roy2020 on 2020/06/22.
//  Copyright © 2020 muzcity. All rights reserved.
//

import UIKit
import TagListView

class ItemDetailTagTableViewCell: UITableViewCell {

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
    
    override func prepareForReuse() {
        super.prepareForReuse()
        
        tagListView?.removeAllTags()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

    private var tagListView : TagListView!
}

extension ItemDetailTagTableViewCell {
    
    func setCell(_ vm : ItemDetailViewModel) {
        tagListView.addTags(vm.genres)
    }
    
}

extension ItemDetailTagTableViewCell {
    
    func createViews() {
        selectionStyle = .none
        
        let label = UILabel(frame: .zero)
        label.font = UIFont.boldSystemFont(ofSize: 22)
        label.text = "카테고리"
        label.numberOfLines = 1
                    
        let tagView = TagListView(frame: .zero)
        tagListView = tagView
        tagView.cornerRadius = 4
        tagView.borderWidth = 1
        tagView.paddingX = 15
        tagView.paddingY = 9
        tagView.marginX = 12
        tagView.marginY = 12
        tagView.textFont = UIFont.systemFont(ofSize: 12)
        tagView.tagBackgroundColor = .white
        tagView.textColor = UIColor.black
        
        contentView.addSubview(label)
        contentView.addSubview(tagView)
        
        label.translatesAutoresizingMaskIntoConstraints = false
        tagView.translatesAutoresizingMaskIntoConstraints = false
        
        tagView.fillHorizontalLayout(margin: 20)
        
        contentView.addConstraints(
            NSLayoutConstraint.constraints(withVisualFormat: "H:|-20-[label]-20-|", options: NSLayoutConstraint.FormatOptions.init(rawValue: 0), metrics: nil, views: ["label":label, "tagView":tagView])
        )
        
        contentView.addConstraints(
            NSLayoutConstraint.constraints(withVisualFormat: "V:|-20-[label(24)]-20-[tagView]-20-|", options: NSLayoutConstraint.FormatOptions.init(rawValue: 0), metrics: nil, views: ["label":label, "tagView":tagView])
        )
        
        
        
    }
    
}
