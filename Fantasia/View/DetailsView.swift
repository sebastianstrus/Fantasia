//
//  DetailsView.swift
//  Fantasia
//
//  Created by Sebastian Strus on 2019-02-10.
//  Copyright © 2019 Sebastian Strus. All rights reserved.
//



import UIKit

let kPadding: CGFloat = 20

class DetailsView: UIView {
    
    var backAction: (() -> Void)?
    var editAction: (() -> Void)?
        
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setup()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    var imageView: UIImageView = {
        let iv = UIImageView()
        iv.backgroundColor = .white
        iv.contentMode = .scaleAspectFill
        return iv
    }()
    
    let titleLabel: UILabel = {
        let label = UILabel()
        label.font = AppFonts.DESCRIPTION_FONT
        label.textAlignment = NSTextAlignment.center
        return label
    }()
    
    let dateLabel: UILabel = {
        let label = UILabel()
        label.font = AppFonts.DATE_FONT
        label.textColor = UIColor.red
        label.textAlignment = NSTextAlignment.center
        return label
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
    
    let editButton: UIButton = {
        let button = UIButton(type: .system)
        button.tintColor = UIColor.white
        button.setImage(UIImage(named: "button_edit"), for: .normal)
        button.layer.cornerRadius = 20
        button.backgroundColor = UIColor(r: 0, g: 0, b: 0, a: 0.3)
        button.clipsToBounds = true
        button.addTarget(self, action: #selector(handleEdit), for: .touchUpInside)
        return button
    }()
    
    @objc func handleBack() {
        backAction?()
    }
    
    @objc func handleEdit() {
        editAction?()
    }
    
    fileprivate func setup() {
        backgroundColor = AppColors.WHITE_GRAY
        
        addSubview(imageView)
        imageView.setShadow()
        
        addSubview(dateLabel)
        dateLabel.setAnchor(top: imageView.bottomAnchor, leading: leadingAnchor, bottom: nil, trailing: trailingAnchor, paddingTop: 10, paddingLeft: 20, paddingBottom: 20, paddingRight: 20, width: 0, height: 30)
        
        addSubview(backButton)
        backButton.setAnchor(top: topAnchor, leading: leadingAnchor, bottom: nil, trailing: nil, paddingTop: 50, paddingLeft: 10, paddingBottom: 0, paddingRight: 0, width: 40, height: 40)
        
        addSubview(editButton)
        editButton.setAnchor(top: topAnchor, leading: nil, bottom: nil, trailing: trailingAnchor, paddingTop: 50, paddingLeft: 0, paddingBottom: 0, paddingRight: 10, width: 40, height: 40)
        
        addSubview(titleLabel)
        titleLabel.setAnchor(top: topAnchor, leading: backButton.trailingAnchor, bottom: nil, trailing: editButton.leadingAnchor, paddingTop: 50, paddingLeft: 20, paddingBottom: 0, paddingRight: 20, width: 0, height: 40)
        
    }
    
    
    // public functions
    func setCanvas(canvas: CanvasObject) {
        let image = ImageController.shared.fetchImage(imageName: (canvas.imageName)!)
        imageView.image = image
        imageView.backgroundColor = UIColor.red
        
        titleLabel.text = (canvas.title != "") ? canvas.title : "No title"
        dateLabel.text = canvas.date?.formatedString()
        
        let imageWidth = Device.SCREEN_WIDTH - 20
        print("Device.SCREEN_WIDTH: \(Device.SCREEN_WIDTH)")
        print("imageWidth: \(imageWidth)")
        let height_by_width = image!.size.height / image!.size.width
        let imageHeight = CGFloat(imageWidth) * height_by_width
        print("imageHeight: \(imageHeight)")
        
        imageView.setAnchor(top: topAnchor, leading: leadingAnchor, bottom: nil, trailing: nil, paddingTop: 100, paddingLeft: 10, paddingBottom: 20, paddingRight: 10, width: CGFloat(imageWidth), height: imageHeight)

    }
    
  
}
