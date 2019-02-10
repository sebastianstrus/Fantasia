//
//  MyCollectionView.swift
//  Fantasia
//
//  Created by Sebastian Strus on 2019-02-03.
//  Copyright © 2019 Sebastian Strus. All rights reserved.
//

import UIKit

class MyCollectionView: UIView {
    
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


