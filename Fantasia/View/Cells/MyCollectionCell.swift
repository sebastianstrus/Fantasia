//
//  MyCollectionCell.swift
//  Fantasia
//
//  Created by Sebastian Strus on 2019-02-09.
//  Copyright © 2019 Sebastian Strus. All rights reserved.
//

import UIKit

protocol MyCollectionCellDelegate: class {
    func delete(cell: MyCollectionCell)
}


class MyCollectionCell: UICollectionViewCell {
    
    weak var delegate: MyCollectionCellDelegate?
    
    
    var canvas : CanvasObject? {
        didSet {
            setCanvas(canvas: canvas!)
        }
    }
    
    var isEditing: Bool = false {
        didSet{
            blurEffectView.isHidden = !isEditing
        }
    }
    
    let imageView: UIImageView = {
        let iv = UIImageView()
        return iv
    }()
    
    
    let blurEffectView: UIVisualEffectView = {
        let blurEffect = UIBlurEffect(style: .extraLight)
        var view = UIVisualEffectView(effect: blurEffect)
        view.layer.cornerRadius = 12
        view.clipsToBounds = true
        return view
    }()
    
    let xButton: UIButton = {
        let button = UIButton(type: .system)
        button.tintColor = UIColor.darkGray
        button.setImage(UIImage(named: "x_button"), for: .normal)
        return button
    }()
    
    @objc func handleDelete() {
        print("handleDelete")
        delegate?.delete(cell: self)
    }
    
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
        blurEffectView.isHidden = !isEditing
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        self.setupLayout()
    }
    
    func setupLayout() {
        
        addSubview(imageView)
        imageView.pinToEdges(view: self, safe: false)
        
        addSubview(blurEffectView)
        blurEffectView.setAnchor(top: topAnchor, leading: leadingAnchor, bottom: nil, trailing: nil, paddingTop: 6, paddingLeft: 6, paddingBottom: 0, paddingRight: 0, width: 24, height: 24)
        
        blurEffectView.contentView.addSubview(xButton)
        xButton.setAnchor(top: blurEffectView.contentView.topAnchor, leading: blurEffectView.contentView.leadingAnchor, bottom: blurEffectView.contentView.bottomAnchor, trailing: blurEffectView.contentView.trailingAnchor, paddingTop: 4, paddingLeft: 4, paddingBottom: 4, paddingRight: 4)
        xButton.addTarget(self, action: #selector(handleDelete), for: .touchUpInside)
        
        
        setShadow()
    }
}
