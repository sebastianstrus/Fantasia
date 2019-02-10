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
        let attributedString = NSMutableAttributedString(attributedString: NSAttributedString(string: Strings.APP_TITLE, attributes: [NSAttributedString.Key.font: AppFonts.TITLE_FONT!, .foregroundColor: UIColor.white]))
        label.attributedText = attributedString
        label.textAlignment = NSTextAlignment.center
        label.shadowColor = .black
        label.shadowOffset = CGSize(width: 2.0, height: 2.0)
        return label
    }()
    
    let dateLabel: UILabel = {
        let label = UILabel()
        let attributedString = NSMutableAttributedString(attributedString: NSAttributedString(string:  Strings.APP_SUBTITLE, attributes: [NSAttributedString.Key.font: AppFonts.SUBTITLE_FONT!, .foregroundColor: UIColor.white]))
        label.attributedText = attributedString
        label.textAlignment = NSTextAlignment.center
        label.shadowColor = .black
        label.shadowOffset = CGSize(width: 1.0, height: 1.0)
        return label
    }()
    
    let backButton: UIButton = {
        let button = UIButton(type: .system)
        button.tintColor = UIColor.white
        button.setImage(UIImage(named: "back_arrow"), for: .normal)
        button.layer.cornerRadius = 20
        button.backgroundColor = UIColor(r: 0, g: 0, b: 0, a: 0.5)
        button.clipsToBounds = true
        button.addTarget(self, action: #selector(handleBack), for: .touchUpInside)
        return button
    }()
    
    @objc func handleBack() {
        backAction?()
    }
    
    func setup() {
        
        backgroundColor = UIColor.white
        addSubview(imageView)
        
        //let imageWidth = Device.SCREEN_WIDTH - 2 * Int(kPadding)
        //imageView.setAnchor(top: topAnchor, leading: leadingAnchor, bottom: nil, trailing: trailingAnchor, paddingTop: 20, paddingLeft: 20, paddingBottom: 20, paddingRight: 20, width: 0, height: CGFloat(imageWidth))
        
        addSubview(titleLabel)
        titleLabel.setAnchor(top: imageView.bottomAnchor, leading: leadingAnchor, bottom: nil, trailing: trailingAnchor, paddingTop: 0, paddingLeft: kPadding, paddingBottom: kPadding, paddingRight: kPadding, width: 0, height: 40)
        
        addSubview(dateLabel)
        dateLabel.setAnchor(top: titleLabel.bottomAnchor, leading: leadingAnchor, bottom: bottomAnchor, trailing: trailingAnchor, paddingTop: 10, paddingLeft: 20, paddingBottom: 20, paddingRight: 20, width: 0, height: 40)
        
        addSubview(backButton)
        backButton.setAnchor(top: topAnchor, leading: leadingAnchor, bottom: nil, trailing: nil, paddingTop: 40, paddingLeft: 20, paddingBottom: 0, paddingRight: 0, width: 40, height: 40)
        
    }
    
    
    // public functions
    func setImageHeight(image_height_by_width: Int) {
        let imageWidth = Device.SCREEN_WIDTH - 2 * Int(kPadding)
        imageView.setAnchor(top: topAnchor, leading: leadingAnchor, bottom: nil, trailing: trailingAnchor, paddingTop: 20, paddingLeft: 20, paddingBottom: 20, paddingRight: 20, width: 0, height: CGFloat(imageWidth * image_height_by_width))
    }
}
