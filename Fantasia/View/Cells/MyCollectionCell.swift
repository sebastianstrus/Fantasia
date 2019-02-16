//
//  MyCollectionCell.swift
//  Fantasia
//
//  Created by Sebastian Strus on 2019-02-09.
//  Copyright © 2019 Sebastian Strus. All rights reserved.
//

import UIKit

class MyCollectionCell: UICollectionViewCell {
    
    
    var canvas : CanvasObject? {
        didSet {
            setCanvas(canvas: canvas!)
        }
    }
    
    let imageView: UIImageView = {
        let iv = UIImageView()
        return iv
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setupLayout()
    }
    
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //public functions
    func setCanvas(canvas: CanvasObject) {
        imageView.image = ImageController.shared.fetchImage(imageName: canvas.imageName!)
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        self.setupLayout()
    }
    
    func setupLayout() {
        self.addSubview(imageView)
        imageView.pinToEdges(view: self, safe: false)
        setShadow()
    }
}
