//
//  GalleryView.swift
//  Paintera
//
//  Created by Sebastian Strus on 2019-02-03.
//  Copyright © 2019 Sebastian Strus. All rights reserved.
//

import UIKit

class GalleryView: UIView {
    
    // MARK: - Initializers
    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - All subviews
    fileprivate let backgroundImageView: UIImageView = {
        let iv = UIImageView()
        iv.image = UIImage(named: "background1")
        return iv
    }()
    
    let collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.minimumLineSpacing = 16
        layout.scrollDirection = .vertical
        let cv = UICollectionView(frame: .zero, collectionViewLayout: layout)
        cv.backgroundColor = .clear
        return cv
    }()
    
    fileprivate let infoLabel: UILabel = {
        let label = UILabel()
        let attributedString = NSMutableAttributedString(attributedString: NSAttributedString(string: "No canvas to show.", attributes: [NSAttributedString.Key.font: AppFonts.INFO_FONT!, .foregroundColor: UIColor.darkGray]))
        label.attributedText = attributedString
        label.textAlignment = NSTextAlignment.center
        return label
    }()
    
    // MARK: - Private functions
    fileprivate func setup() {
        backgroundColor = AppColors.WHITE_GRAY
        addSubview(backgroundImageView)
        backgroundImageView.pinToEdges(view: self, safe: false)
        
        addSubview(collectionView)
        collectionView.setAnchor(top: safeTopAnchor,
                                 leading: leadingAnchor,
                                 bottom: bottomAnchor,
                                 trailing: trailingAnchor,
                                 paddingTop: 0,
                                 paddingLeft: 0,
                                 paddingBottom: 0,
                                 paddingRight: 0)
        
        collectionView.addSubview(infoLabel)
        infoLabel.setAnchor(top: safeTopAnchor,
                            leading: leadingAnchor,
                            bottom: bottomAnchor,
                            trailing: trailingAnchor,
                            paddingTop: 0,
                            paddingLeft: 0,
                            paddingBottom: 0,
                            paddingRight: 0)
    }
    
    // MARK: - Public functions
    func reload(isEmpty: Bool) {
        infoLabel.isHidden = !isEmpty
        collectionView.reloadData()
    }
    
    func setDelegate(d: UICollectionViewDelegate) {
        collectionView.delegate = d
    }
    
    func setDataSource(ds: UICollectionViewDataSource) {
        collectionView.dataSource = ds
    }
    
    func registerCell(className: AnyClass, id: String) {
        collectionView.register(className, forCellWithReuseIdentifier: id)
    }
    
    func toggleInfoLabel(isEmpty: Bool) {
        infoLabel.isHidden = !isEmpty
    }
}


