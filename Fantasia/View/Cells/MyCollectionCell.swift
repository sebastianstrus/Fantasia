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
        let iv = UIImageView(image: UIImage(named: "blur_background"))
        return iv
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        self.addSubview(imageView)
        imageView.pinToEdges(view: self)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
