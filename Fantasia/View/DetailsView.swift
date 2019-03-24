//
//  DetailsView.swift
//  Fantasia
//
//  Created by Sebastian Strus on 2019-02-10.
//  Copyright © 2019 Sebastian Strus. All rights reserved.
//



import UIKit

class DetailsView: UIView {
    
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
    
    fileprivate var imageView: UIImageView = {
        let iv = UIImageView()
        iv.backgroundColor = .white
        iv.contentMode = .scaleAspectFill
        return iv
    }()
    
    fileprivate let dateLabel: UILabel = {
        let label = UILabel()
        label.font = AppFonts.DATE_FONT
        label.textColor = UIColor(r: 200, g: 20, b: 20)
        label.textAlignment = NSTextAlignment.center
        return label
    }()
    
    fileprivate func setup() {
        backgroundColor = AppColors.WHITE_GRAY
        
        addSubview(backgroundImageView)
        backgroundImageView.pinToEdges(view: self, safe: false)
        
        addSubview(imageView)
        imageView.setShadow()
        
        addSubview(dateLabel)
        dateLabel.setAnchor(top: imageView.bottomAnchor,
                            leading: leadingAnchor,
                            bottom: nil,
                            trailing: trailingAnchor,
                            paddingTop: Device.IS_IPHONE ? 10 : 20,
                            paddingLeft: Device.IS_IPHONE ? 20 : 40,
                            paddingBottom: 0,
                            paddingRight: Device.IS_IPHONE ? 20 : 40,
                            width: 0,
                            height: Device.IS_IPHONE ? 30 : 60)
    }
    
    // public functions
    func setCanvas(canvas: CanvasObject) {
        let image = ImageController.shared.fetchImage(imageName: (canvas.imageName)!)
        imageView.image = image
        
        dateLabel.text = canvas.date?.formatedString()
        
        let imageWidth = Device.SCREEN_WIDTH - (Device.IS_IPHONE ? 20 : 40)
        let height_by_width = image!.size.height / image!.size.width
        let imageHeight = CGFloat(imageWidth) * height_by_width
        
        imageView.setAnchor(top: topAnchor,
                            leading: leadingAnchor,
                            bottom: nil,
                            trailing: nil,
                            paddingTop: Device.IS_IPHONE ? 10 : 20,
                            paddingLeft: Device.IS_IPHONE ? 10 : 20,
                            paddingBottom: Device.IS_IPHONE ? 10 : 20,
                            paddingRight: 0,
                            width: CGFloat(imageWidth),
                            height: imageHeight)
    }
}
