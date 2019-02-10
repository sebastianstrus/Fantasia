//
//  MyCollectionCell.swift
//  Fantasia
//
//  Created by Sebastian Strus on 2019-02-09.
//  Copyright © 2019 Sebastian Strus. All rights reserved.
//

import UIKit

class MyCollectionCell: UICollectionViewCell {
    
    
    let imageView: UIImageView = {
        let iv = UIImageView()
        return iv
    }()
    
    let titleLabel: UILabel = {
        let label = UILabel()
        return label
    }()
    
    let dateLabel: UILabel = {
        let label = UILabel()
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
                
        self.addSubview(imageView)
        imageView.setAnchor(top: topAnchor, leading: leadingAnchor, bottom: bottomAnchor, trailing: trailingAnchor, paddingTop: 0, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: 0, height: 0)
        
        imageView.pinToEdges(view: self)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
