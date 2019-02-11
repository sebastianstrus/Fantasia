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
    
    let collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.minimumLineSpacing = 16
        layout.scrollDirection = .vertical
        let cv = UICollectionView(frame: .zero, collectionViewLayout: layout)
        cv.backgroundColor = .clear
        return cv
    }()
    
    let backgroundIV: UIImageView = {
        let iv = UIImageView(image: UIImage(named: "blur_background"))//UIImageView(image: #imageLiteral(resourceName: "restaurant"))
        iv.contentMode = .scaleAspectFill
        return iv
    }()
    
    let backButton: UIButton = {
        let button = UIButton(type: .system)
        button.tintColor = UIColor.white
        button.setImage(UIImage(named: "back_arrow"), for: .normal)
        button.layer.cornerRadius = 20
        button.backgroundColor = UIColor(r: 0, g: 0, b: 0, a: 0.3)
        button.clipsToBounds = true
        button.addTarget(self, action: #selector(handleBack), for: .touchUpInside)
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
        addSubview(backgroundIV)
        backgroundIV.pinToEdges(view: self)
        
        addSubview(collectionView)
        collectionView.pinToEdges(view: self)
        
        addSubview(backButton)
        backButton.setAnchor(top: topAnchor, leading: leadingAnchor, bottom: nil, trailing: nil, paddingTop: 60, paddingLeft: 20, paddingBottom: 0, paddingRight: 0, width: 40, height: 40)
    }
    
    @objc func handleBack() {
        backAction?()
    }
    
    func reload() {
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
}


