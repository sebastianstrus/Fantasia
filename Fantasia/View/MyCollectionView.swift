//
//  MyCollectionView.swift
//  Fantasia
//
//  Created by Sebastian Strus on 2019-02-03.
//  Copyright © 2019 Sebastian Strus. All rights reserved.
//

import UIKit

class MyCollectionView: UIView {
    
    var backAction: (() -> Void)?
    var editAction: (() -> Void)?
    
    let safeAreaBackground: UIView = {
        let view = UIView()
        view.backgroundColor = AppColors.DODGERBLUE
        return view
    }()
    
    let navBarView: UIView = {
        let view = UIView()
        view.backgroundColor = AppColors.DODGERBLUE
        return view
    }()
    
    let titleLabel: UILabel = {
        let label = UILabel()
        label.text = "Collection"
        label.textAlignment = .center
        label.textColor = AppColors.WHITE_GRAY
        label.font = UIFont(name: "Oswald-Medium", size: 20)
        return label
    }()

    
    let backgroundImageView: UIImageView = {
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
    
    let infoLabel: UILabel = {
        let label = UILabel()
        let attributedString = NSMutableAttributedString(attributedString: NSAttributedString(string: "No canvas to show.", attributes: [NSAttributedString.Key.font: AppFonts.INFO_FONT!, .foregroundColor: UIColor.darkGray]))
        label.attributedText = attributedString
        label.textAlignment = NSTextAlignment.center
        return label
    }()
    
    let backButton: UIButton = {
        let button = UIButton(type: .system)
        button.tintColor = UIColor.white
        button.setImage(UIImage(named: "back_arrow"), for: .normal)
        button.addTarget(self, action: #selector(handleBack), for: .touchUpInside)
        return button
    }()
    
    let editButton: UIButton = {
        let button = UIButton(type: .system)
        button.tintColor = UIColor.white
        button.setTitle("Edit", for: .normal)
        button.titleLabel?.textAlignment = .center
        button.titleLabel?.textColor = AppColors.WHITE_GRAY
        button.titleLabel?.font = .systemFont(ofSize: 18)
        
        
        button.addTarget(self, action: #selector(handleEdit), for: .touchUpInside)
        return button
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setup() {
        backgroundColor = AppColors.WHITE_GRAY
        addSubview(backgroundImageView)
        backgroundImageView.pinToEdges(view: self, safe: false)
//        addSubview(backgroundIV)
//        backgroundIV.pinToEdges(view: self, safe: false)
        
        addSubview(safeAreaBackground)
        safeAreaBackground.setAnchor(top: topAnchor, leading: leadingAnchor, bottom: nil, trailing: trailingAnchor, paddingTop: 0, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: 0, height: 44)
        
        addSubview(navBarView)
        navBarView.setAnchor(top: safeTopAnchor, leading: leadingAnchor, bottom: nil, trailing: trailingAnchor, paddingTop: 0, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: 0, height: 44)
        
        navBarView.addSubview(backButton)
        backButton.setAnchor(top: nil, leading: navBarView.leadingAnchor, bottom: nil, trailing: nil, paddingTop: 0, paddingLeft: 10, paddingBottom: 0, paddingRight: 0, width: 32, height: 32)
        backButton.centerYAnchor.constraint(equalTo: navBarView.centerYAnchor).isActive = true
        
        navBarView.addSubview(editButton)
        editButton.setAnchor(top: nil, leading: nil, bottom: nil, trailing: navBarView.trailingAnchor, paddingTop: 0, paddingLeft: 0, paddingBottom: 0, paddingRight: 10, width: 50, height: 32)
        editButton.centerYAnchor.constraint(equalTo: navBarView.centerYAnchor).isActive = true
        
        navBarView.addSubview(titleLabel)
        titleLabel.setAnchor(top: navBarView.topAnchor, leading: navBarView.leadingAnchor, bottom: navBarView.bottomAnchor, trailing: navBarView.trailingAnchor, paddingTop: 0, paddingLeft: 60, paddingBottom: 0, paddingRight: 60, width: 0, height: 32)
        titleLabel.centerYAnchor.constraint(equalTo: navBarView.centerYAnchor).isActive = true
        
        
        
        
        addSubview(collectionView)
        collectionView.setAnchor(top: navBarView.bottomAnchor, leading: leadingAnchor, bottom: bottomAnchor, trailing: trailingAnchor, paddingTop: 0, paddingLeft: 0, paddingBottom: 0, paddingRight: 0)
        
        collectionView.addSubview(infoLabel)
        infoLabel.setAnchor(top: navBarView.bottomAnchor, leading: leadingAnchor, bottom: bottomAnchor, trailing: trailingAnchor, paddingTop: 0, paddingLeft: 0, paddingBottom: 0, paddingRight: 0)
        
//        addSubview(collectionView)
//        collectionView.pinToEdges(view: self, safe: true)
        
        //addSubview(backButton)
        //backButton.setAnchor(top: safeTopAnchor, leading: leadingAnchor, bottom: nil, trailing: nil, paddingTop: 10, paddingLeft: 10, paddingBottom: 0, paddingRight: 0, width: 30, height: 30)
    }
    
    @objc func handleBack() {
        backAction?()
    }
    
    @objc func handleEdit() {
        editAction?()
    }
    
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
    
    func toggleEditButton(isEditing: Bool) {
        editButton.setTitle(isEditing ? "Done" : "Edit", for: .normal)
    }
    
    public func toggleInfoLabel(isEmpty: Bool) {
        infoLabel.isHidden = !isEmpty
    }
}


