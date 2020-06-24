//
//  ItemDetailScreenShotTableViewCell.swift
//  BackPac
//
//  Created by roy2020 on 2020/06/21.
//  Copyright © 2020 muzcity. All rights reserved.
//

import UIKit
import Kingfisher

class ItemDetailScreenShotTableViewCell: UITableViewCell {

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
    
    private var collection : UICollectionView!
    private var collectionViewFlowLayout : UICollectionViewFlowLayout!

    private var urlList : [String] = [] {
        didSet {
            collectionViewFlowLayout.itemSize = collectionItemSize(urlList.first ?? "")
            collection.reloadData()
        }
    }
    
    static let CELL_MARGIN:CGFloat = 4
    static let CELL_SPACING:CGFloat = 4
    static let IMAGE_WIDTH:CGFloat = 169
    static let IMAGE_HEIGHT:CGFloat = 300
    static let CELL_HEIGHT: CGFloat = ItemDetailScreenShotTableViewCell.IMAGE_HEIGHT + (ItemDetailScreenShotTableViewCell.CELL_MARGIN*2)
}

extension ItemDetailScreenShotTableViewCell {
    func setCell(_ vm : ItemDetailViewModel) {
        let list = vm.screenshotUrls
        urlList = list
    }
}

extension ItemDetailScreenShotTableViewCell {
    
    private func collectionItemSize(_ urlString : String) -> CGSize {
        let path = try? urlString.asURL().lastPathComponent
        let defaultSize = CGSize(width: ItemDetailScreenShotTableViewCell.IMAGE_WIDTH, height: ItemDetailScreenShotTableViewCell.IMAGE_HEIGHT)
        
        guard let fileName = path else {
            return defaultSize
        }
        
        let sepa = fileName.components(separatedBy: "bb.")
        guard sepa.count == 2 else {
            return defaultSize
        }
        
        let value = sepa[0].components(separatedBy: "x")
        let widthFileName = Int(value.first ?? "")
        guard let width = widthFileName else {
            return defaultSize
        }
        let heightFileName = Int(value.last ?? "")
        guard let height = heightFileName else {
            return defaultSize
        }
        
        let contentWidth = width * Int(ItemDetailScreenShotTableViewCell.IMAGE_HEIGHT) / height
        return CGSize(width: CGFloat(contentWidth), height: ItemDetailScreenShotTableViewCell.IMAGE_HEIGHT)
    }
    
    private func createViews() {
        
        selectionStyle = .none
        
        let flowLayout = UICollectionViewFlowLayout()
        flowLayout.itemSize = CGSize(width: ItemDetailScreenShotTableViewCell.IMAGE_WIDTH, height: ItemDetailScreenShotTableViewCell.IMAGE_HEIGHT)
        flowLayout.scrollDirection = .horizontal
        flowLayout.minimumLineSpacing = ItemDetailScreenShotTableViewCell.CELL_SPACING
        flowLayout.minimumInteritemSpacing = ItemDetailScreenShotTableViewCell.CELL_SPACING
        flowLayout.sectionInset = UIEdgeInsets(top: 0, left: ItemDetailScreenShotTableViewCell.CELL_MARGIN, bottom: 0, right: ItemDetailScreenShotTableViewCell.CELL_MARGIN)
        collectionViewFlowLayout = flowLayout
        
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: flowLayout)
        collectionView.register(ItemDetailScreenShotCollectionViewCell.self, forCellWithReuseIdentifier: ItemDetailScreenShotCollectionViewCell.cellName())
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.backgroundColor = .white
        collection = collectionView
        
        contentView.addSubview(collection)
        
        collection.fillLayout()
    }
}

extension ItemDetailScreenShotTableViewCell : UICollectionViewDataSource, UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return urlList.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ItemDetailScreenShotCollectionViewCell.cellName(), for: indexPath)
        
        if let screenShotCell = cell as? ItemDetailScreenShotCollectionViewCell {
            screenShotCell.setCell(urlList[indexPath.row])
        }
        
        return cell
    }
    
    
}




class ItemDetailScreenShotCollectionViewCell : UICollectionViewCell {
    
    override init(frame: CGRect) {
        super.init(frame: .zero)
        
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
        
        imageView.image = nil
    }
    
    
    private func createViews() {
        let imgView = UIImageView(frame: .zero)
        imageView = imgView
        imageView.contentMode = .scaleAspectFill
        
        contentView.addSubview(imgView)
        imageView.fillLayout()
    }
    
    func setCell(_ urlString : String) {
        if let url = URL(string: urlString) {
            imageView.kf.setImage(with: url)
        }
    }
    
    var imageView : UIImageView!
}
