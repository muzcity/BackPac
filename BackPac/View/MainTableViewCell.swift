//
//  MainTableViewCell.swift
//  BackPac
//
//  Created by roy2020 on 2020/06/20.
//  Copyright © 2020 muzcity. All rights reserved.
//

import UIKit
import Kingfisher
import SwiftyStarRatingView

class MainTableViewCell: UITableViewCell {
    
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
        
        arkworkImageView.image = nil
        appNameLabel.text = ""
        sellerLabel.text = ""
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

    
    
    ///MARK: - variables
    private var arkworkImageView: UIImageView!
    private var appNameLabel : UILabel!
    private var sellerLabel : UILabel!
    private var primaryCategory : UILabel!
    private var formattedPrice : UILabel!
    private var ratingView : SwiftyStarRatingView!
    
    
    
    
    
    ///MARK: - constants
    static private let TOP_MARGIN : CGFloat = 8
    static private let HORIZONTAL_MARGIN : CGFloat = 8
    static private var IMAGEVIEW_HEIGHT : CGFloat {
        return UIScreen.main.bounds.size.width - (MainTableViewCell.HORIZONTAL_MARGIN*2)
    }
    static private let INFO_HEIGHT : CGFloat = 50
    static private let OPT_INFO_HEIGHT : CGFloat = 50
    
    static var MAINTABLEVIEWCELL_HEIGHT : CGFloat {
        return MainTableViewCell.IMAGEVIEW_HEIGHT + MainTableViewCell.INFO_HEIGHT + MainTableViewCell.OPT_INFO_HEIGHT + MainTableViewCell.TOP_MARGIN
    }
}

///MARK: - public
extension MainTableViewCell {
    func setCell(_ viewModel : ItemDetailViewModel?) {
        
        if let urlString = viewModel?.artworkUrl512,
            let url = URL(string:urlString) {
            arkworkImageView.kf.setImage(with: url)
        }
        
        appNameLabel.text = viewModel?.trackName
        sellerLabel.text = viewModel?.sellerName
        ratingView.value = CGFloat( viewModel?.averageUserRating ?? 0 )
        
        
        primaryCategory.text = viewModel?.genres.first
        formattedPrice.text = viewModel?.formattedPrice
        
    }
}

///MARK: - private
extension MainTableViewCell {
    private func createViews() {
        
        self.selectionStyle = .none
        
        let card = UIView(frame: .zero)
        card.backgroundColor = .white
        card.borderWidth = 1
        card.cornerRadius = 4
        card.borderColor = UIColor.gray.cgColor
        card.clipsToBounds = true
        
        self.contentView.addSubview(card)
        card.translatesAutoresizingMaskIntoConstraints = false
        card.leftAnchor.constraint(equalTo: contentView.leftAnchor, constant: 8).isActive = true
        card.rightAnchor.constraint(equalTo: contentView.rightAnchor, constant: -8).isActive = true
        card.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 8).isActive = true
        card.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: 0).isActive = true
        
        
        /// 이미지 영역
        let iv = UIImageView(frame: .zero)
        iv.contentMode = .scaleAspectFill
        arkworkImageView = iv

        card.addSubview(iv)
        
        /// 상품정보
        let info1 = UIView(frame: .zero)
        card.addSubview(info1)
        
        /// 카테고리 가격정보
        let info2 = UIView(frame: .zero)
        card.addSubview(info2)
        
        
        let imageViewHeight = MainTableViewCell.IMAGEVIEW_HEIGHT
        
        iv.translatesAutoresizingMaskIntoConstraints = false
        info1.translatesAutoresizingMaskIntoConstraints = false
        info2.translatesAutoresizingMaskIntoConstraints = false
        
        let imageHConstraints = NSLayoutConstraint.constraints(withVisualFormat: "H:|[iv]|", options: NSLayoutConstraint.FormatOptions.init(rawValue: 0), metrics: nil, views: ["iv":iv])
        
        let info1HConstraints = NSLayoutConstraint.constraints(withVisualFormat: "H:|[info1]|", options: NSLayoutConstraint.FormatOptions.init(rawValue: 0), metrics: nil, views: ["info1":info1])
        
        let info2HConstraints = NSLayoutConstraint.constraints(withVisualFormat: "H:|[info2]|", options: NSLayoutConstraint.FormatOptions.init(rawValue: 0), metrics: nil, views: ["info2":info2])
        
        let vConstraints = NSLayoutConstraint.constraints(withVisualFormat: "V:|[iv(height)][info1(50)][info2(50)]|", options: NSLayoutConstraint.FormatOptions.init(rawValue: 0), metrics: ["height":imageViewHeight], views: ["iv":iv,"info1":info1,"info2":info2])
        
        
        card.addConstraints(imageHConstraints)
        card.addConstraints(info1HConstraints)
        card.addConstraints(info2HConstraints)
        card.addConstraints(vConstraints)
        
        createProductInfoViews(info1)
        createAdditionalInfoViews(info2)
        
    }
    
    private func createProductInfoViews(_ parentView:UIView) {
        let line = UIView.line()
        
        let primary = UILabel(frame:.zero)
        primary.font = UIFont.boldSystemFont(ofSize: 16)
        primary.numberOfLines = 1
        appNameLabel = primary
        
        let secondary = UILabel(frame: .zero)
        secondary.font = UIFont.systemFont(ofSize: 12)
        secondary.numberOfLines = 1
        sellerLabel = secondary
        
        parentView.addSubview(line)
        parentView.addSubview(primary)
        parentView.addSubview(secondary)
        
        line.translatesAutoresizingMaskIntoConstraints = false
        primary.translatesAutoresizingMaskIntoConstraints = false
        secondary.translatesAutoresizingMaskIntoConstraints = false
        
        let lineHConstraints = NSLayoutConstraint.constraints(withVisualFormat: "H:|[line]|", options: NSLayoutConstraint.FormatOptions.init(rawValue: 0), metrics: nil, views: ["line":line])
        let l1HConstraints = NSLayoutConstraint.constraints(withVisualFormat: "H:|-8-[primary]-8-|", options: NSLayoutConstraint.FormatOptions.init(rawValue: 0), metrics: nil, views: ["primary":primary])
        let l2HConstraints = NSLayoutConstraint.constraints(withVisualFormat: "H:|-8-[secondary]-8-|", options: NSLayoutConstraint.FormatOptions.init(rawValue: 0), metrics: nil, views: ["secondary":secondary])
        
        let vConstraints = NSLayoutConstraint.constraints(withVisualFormat: "V:|[line(1)]-4-[primary]-4-[secondary]", options: NSLayoutConstraint.FormatOptions.init(rawValue: 0), metrics: nil, views: ["line":line, "primary":primary, "secondary":secondary])
        
        parentView.addConstraints(lineHConstraints)
        parentView.addConstraints(l1HConstraints)
        parentView.addConstraints(l2HConstraints)
        parentView.addConstraints(vConstraints)
    }
    
    private func createAdditionalInfoViews(_ parentView:UIView) {
        let line = UIView.line()
        
        let primary = UILabel(frame:.zero)
        primary.font = UIFont.boldSystemFont(ofSize: 16)
        primary.numberOfLines = 1
        primaryCategory = primary
        
        let rating = SwiftyStarRatingView()
        rating.minimumValue = 5
        rating.maximumValue = 5
        rating.isEnabled = false
        rating.allowsHalfStars = true
        rating.accurateHalfStars = true
        rating.tintColor = UIColor.orange
        ratingView = rating
        
        let secondary = UILabel(frame: .zero)
        secondary.font = UIFont.systemFont(ofSize: 12)
        secondary.numberOfLines = 1
        formattedPrice = secondary
        
        parentView.addSubview(line)
        parentView.addSubview(primary)
        parentView.addSubview(rating)
        parentView.addSubview(secondary)
        
        line.translatesAutoresizingMaskIntoConstraints = false
        primary.translatesAutoresizingMaskIntoConstraints = false
        rating.translatesAutoresizingMaskIntoConstraints = false
        secondary.translatesAutoresizingMaskIntoConstraints = false
        
        let lineHConstraints = NSLayoutConstraint.constraints(withVisualFormat: "H:|[line]|", options: NSLayoutConstraint.FormatOptions.init(rawValue: 0), metrics: nil, views: ["line":line])
        let l1HConstraints = NSLayoutConstraint.constraints(withVisualFormat: "H:|-8-[primary]-8-[rating(100)]-8-|", options: NSLayoutConstraint.FormatOptions.init(rawValue: 0), metrics: nil, views: ["primary":primary,"rating":rating])
        let l2HConstraints = NSLayoutConstraint.constraints(withVisualFormat: "H:|-8-[secondary]-8-|", options: NSLayoutConstraint.FormatOptions.init(rawValue: 0), metrics: nil, views: ["secondary":secondary])
        
        let vConstraints = NSLayoutConstraint.constraints(withVisualFormat: "V:|[line(1)]-4-[primary]-4-[secondary]", options: NSLayoutConstraint.FormatOptions.init(rawValue: 0), metrics: nil, views: ["line":line, "primary":primary, "secondary":secondary])
        
        let ratingCenterYConstraint = NSLayoutConstraint(item: primary, attribute: NSLayoutConstraint.Attribute.centerY, relatedBy: NSLayoutConstraint.Relation.equal, toItem: rating, attribute: NSLayoutConstraint.Attribute.centerY, multiplier: 1, constant: 0)
        let ratingHeightConstraint = NSLayoutConstraint(item: rating, attribute: NSLayoutConstraint.Attribute.height, relatedBy: NSLayoutConstraint.Relation.equal, toItem: nil, attribute: NSLayoutConstraint.Attribute.notAnAttribute, multiplier: 1, constant: 20)
        
        
        parentView.addConstraints(lineHConstraints)
        parentView.addConstraints(l1HConstraints)
        parentView.addConstraint(ratingCenterYConstraint)
        parentView.addConstraint(ratingHeightConstraint)
        parentView.addConstraints(l2HConstraints)
        parentView.addConstraints(vConstraints)
    }
    
    
}
