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
    
    // MARK: - Initializers
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setup()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Public actions
    var backAction: (() -> Void)?
    var editAction: (() -> Void)?
    
    // MARK: - All subviews
    fileprivate let backgroundImageView: UIImageView = {
        let iv = UIImageView()
        iv.image = UIImage(named: "background1")
        return iv
    }()
    
    fileprivate let safeAreaBackground: UIView = {
        let view = UIView()
        view.backgroundColor = AppColors.DODGERBLUE
        return view
    }()
    
    fileprivate let navBarView: UIView = {
        let view = UIView()
        view.backgroundColor = AppColors.DODGERBLUE
        return view
    }()
    
    fileprivate var imageView: UIImageView = {
        let iv = UIImageView()
        iv.backgroundColor = .white
        iv.contentMode = .scaleAspectFill
        return iv
    }()
    
    fileprivate let titleLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.textColor = AppColors.WHITE_GRAY
        label.font = UIFont(name: "Oswald-Medium", size: 20)
        return label
    }()
    
    fileprivate let dateLabel: UILabel = {
        let label = UILabel()
        label.font = AppFonts.DATE_FONT
        label.textColor = UIColor.red
        label.textAlignment = NSTextAlignment.center
        return label
    }()
    
    fileprivate let backButton: UIButton = {
        let button = UIButton(type: .system)
        button.tintColor = UIColor.white
        button.setImage(UIImage(named: "back_arrow"), for: .normal)
        button.addTarget(self, action: #selector(handleBack), for: .touchUpInside)
        return button
    }()
    
    fileprivate let editButton: UIButton = {
        let button = UIButton(type: .system)
        button.tintColor = UIColor.white
        button.setImage(UIImage(named: "button_edit"), for: .normal)
        button.addTarget(self, action: #selector(handleEdit), for: .touchUpInside)
        return button
    }()
    
    @objc fileprivate func handleBack() {
        backAction?()
    }
    
    @objc fileprivate func handleEdit() {
        editAction?()
    }
    
    fileprivate func setup() {
        backgroundColor = AppColors.WHITE_GRAY
        
        addSubview(backgroundImageView)
        backgroundImageView.pinToEdges(view: self, safe: false)
        
        addSubview(safeAreaBackground)
        safeAreaBackground.setAnchor(top: topAnchor, leading: leadingAnchor, bottom: nil, trailing: trailingAnchor, paddingTop: 0, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: 0, height: 44)
        
        addSubview(navBarView)
        navBarView.setAnchor(top: safeTopAnchor, leading: leadingAnchor, bottom: nil, trailing: trailingAnchor, paddingTop: 0, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: 0, height: 44)
        
        navBarView.addSubview(backButton)
        backButton.setAnchor(top: navBarView.topAnchor, leading: navBarView.leadingAnchor, bottom: nil, trailing: nil, paddingTop: 0, paddingLeft: 10, paddingBottom: 0, paddingRight: 0, width: 44, height: 44)
        
        navBarView.addSubview(editButton)
        editButton.setAnchor(top: nil, leading: nil, bottom: nil, trailing: navBarView.trailingAnchor, paddingTop: 0, paddingLeft: 0, paddingBottom: 0, paddingRight: 10, width: 32, height: 32)
        editButton.centerYAnchor.constraint(equalTo: navBarView.centerYAnchor).isActive = true
        
        navBarView.addSubview(titleLabel)
        titleLabel.setAnchor(top: navBarView.topAnchor, leading: backButton.trailingAnchor, bottom: navBarView.bottomAnchor, trailing: editButton.leadingAnchor, paddingTop: 0, paddingLeft: 20, paddingBottom: 0, paddingRight: 20)
        
        
        addSubview(imageView)
        imageView.setShadow()
        
        addSubview(dateLabel)
        dateLabel.setAnchor(top: imageView.bottomAnchor, leading: leadingAnchor, bottom: nil, trailing: trailingAnchor, paddingTop: 10, paddingLeft: 20, paddingBottom: 0, paddingRight: 20, width: 0, height: 30)
        
        
    }
    
    
    // public functions
    func setCanvas(canvas: CanvasObject) {
        let image = ImageController.shared.fetchImage(imageName: (canvas.imageName)!)
        imageView.image = image
        imageView.backgroundColor = UIColor.red
        
        titleLabel.text = (canvas.title != "") ? canvas.title : "No title"
        dateLabel.text = canvas.date?.formatedString()
        
        let imageWidth = Device.SCREEN_WIDTH - 20
        let height_by_width = image!.size.height / image!.size.width
        let imageHeight = CGFloat(imageWidth) * height_by_width
        
        imageView.setAnchor(top: titleLabel.bottomAnchor, leading: leadingAnchor, bottom: nil, trailing: nil, paddingTop: 10, paddingLeft: 10, paddingBottom: 10, paddingRight: 0, width: CGFloat(imageWidth), height: imageHeight)

    }
    
  
}
