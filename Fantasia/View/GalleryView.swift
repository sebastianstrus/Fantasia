//
//  GalleryView.swift
//  Fantasia
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
    
    // MARK: - Public actions
    //var backAction: (() -> Void)?
    //var editAction: (() -> Void)?
    
    // MARK: - All subviews
    /*fileprivate let safeAreaBackground: UIView = {
        let view = UIView()
        view.backgroundColor = AppColors.DODGERBLUE
        return view
    }()
    
    fileprivate let navBarView: UIView = {
        let view = UIView()
        view.backgroundColor = AppColors.DODGERBLUE
        return view
    }()
    
    fileprivate let titleLabel: UILabel = {
        let label = UILabel()
        label.text = "Gallery"
        label.textAlignment = .center
        label.textColor = AppColors.WHITE_GRAY
        label.font = UIFont(name: "Oswald-Medium", size: Device.IS_IPHONE ? 20 : 40)
        return label
    }()*/

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
    
    /*fileprivate let backButton: UIButton = {
        let button = UIButton(type: .system)
        button.tintColor = UIColor.white
        button.setImage(UIImage(named: "back_arrow"), for: .normal)
        button.addTarget(self, action: #selector(handleBack), for: .touchUpInside)
        return button
    }()*/
    
    /*fileprivate let editButton: UIButton = {
        let button = UIButton(type: .system)
        button.tintColor = UIColor.white
        button.setTitle("Edit", for: .normal)
        button.titleLabel?.textAlignment = .center
        button.titleLabel?.textColor = AppColors.WHITE_GRAY
        button.titleLabel?.font = .systemFont(ofSize: Device.IS_IPHONE ? 22 : 44)
        button.addTarget(self, action: #selector(handleEdit), for: .touchUpInside)
        return button
    }()*/
    
    // MARK: - Private functions
    fileprivate func setup() {
        backgroundColor = AppColors.WHITE_GRAY
        addSubview(backgroundImageView)
        backgroundImageView.pinToEdges(view: self, safe: false)
        //backgroundImageView.pinToEdges(view: self, safe: false)
        
        /*addSubview(safeAreaBackground)
        safeAreaBackground.setAnchor(top: topAnchor,
                                     leading: leadingAnchor,
                                     bottom: nil,
                                     trailing: trailingAnchor,
                                     paddingTop: 0,
                                     paddingLeft: 0,
                                     paddingBottom: 0,
                                     paddingRight: 0,
                                     width: 0,
                                     height: Device.IS_IPHONE ? 44 : 88)*/
        
        /*addSubview(navBarView)
        navBarView.setAnchor(top: safeTopAnchor,
                             leading: leadingAnchor,
                             bottom: nil,
                             trailing: trailingAnchor,
                             paddingTop: 0,
                             paddingLeft: 0,
                             paddingBottom: 0,
                             paddingRight: 0,
                             width: 0,
                             height: Device.IS_IPHONE ? 44 : 88)*/
        
        /*navBarView.addSubview(backButton)
        backButton.setAnchor(top: navBarView.topAnchor,
                             leading: navBarView.leadingAnchor,
                             bottom: nil,
                             trailing: nil,
                             paddingTop: 0,
                             paddingLeft: 10,
                             paddingBottom: 0,
                             paddingRight: 0,
                             width: Device.IS_IPHONE ? 44 : 88,
                             height: Device.IS_IPHONE ? 44 : 88)*/
        
        /*navBarView.addSubview(editButton)
        editButton.setAnchor(top: navBarView.topAnchor,
                             leading: nil,
                             bottom: nil,
                             trailing: navBarView.trailingAnchor,
                             paddingTop: 0,
                             paddingLeft: 0,
                             paddingBottom: 0,
                             paddingRight: 10,
                             width: Device.IS_IPHONE ? 60 : 120,
                             height: Device.IS_IPHONE ? 44 : 88)
        editButton.centerYAnchor.constraint(equalTo: navBarView.centerYAnchor).isActive = true*/
        
        /*navBarView.addSubview(titleLabel)
        titleLabel.setAnchor(top: navBarView.topAnchor,
                             leading: navBarView.leadingAnchor,
                             bottom: navBarView.bottomAnchor,
                             trailing: navBarView.trailingAnchor,
                             paddingTop: 0,
                             paddingLeft: Device.IS_IPHONE ? 60 : 120,
                             paddingBottom: 0,
                             paddingRight: Device.IS_IPHONE ? 60 : 120,
                             width: 0,
                             height: Device.IS_IPHONE ? 44 : 88)
        titleLabel.centerYAnchor.constraint(equalTo: navBarView.centerYAnchor).isActive = true*/
        
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
    /*
    @objc fileprivate func handleBack() {
        backAction?()
    }
    
    @objc fileprivate func handleEdit() {
        editAction?()
    }*/
    
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
    
    /*func toggleEditButton(isEditing: Bool) {
        editButton.setTitle(isEditing ? "Done" : "Edit", for: .normal)
    }*/
    
    public func toggleInfoLabel(isEmpty: Bool) {
        infoLabel.isHidden = !isEmpty
    }
}


