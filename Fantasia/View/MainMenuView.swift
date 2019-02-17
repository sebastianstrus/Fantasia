//
//  MainMenuView.swift
//  Fantasia
//
//  Created by Sebastian Strus on 2019-02-01.
//  Copyright © 2019 Sebastian Strus. All rights reserved.
//


import UIKit

let kButtonsStackViewHeight: CGFloat = Device.IS_IPHONE ? 90 : 170
let kStackViewMargin: CGFloat = Device.IS_IPHONE ? 120 : 300

class MainMenuView: UIView {
    
    var newCanvasAction: (() -> Void)?
    var myCollectionAction: (() -> Void)?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    var backgroundImageView: UIImageView = {
        let iv = UIImageView(image: UIImage(named: "blur_background"))
        iv.backgroundColor = .white
        iv.contentMode = .scaleAspectFill
        return iv
    }()
    
    var topContainer: UIView = {
        let view = UIView()
        return view
    }()
    
    var bottomContainer: UIView = {
        let view = UIView()
        return view
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
    
    let subtitleLabel: UILabel = {
        let label = UILabel()
        let attributedString = NSMutableAttributedString(attributedString: NSAttributedString(string:  Strings.APP_SUBTITLE, attributes: [NSAttributedString.Key.font: AppFonts.SUBTITLE_FONT!, .foregroundColor: UIColor.white]))
        label.attributedText = attributedString
        label.textAlignment = NSTextAlignment.center
        label.shadowColor = .black
        label.shadowOffset = CGSize(width: 1.0, height: 1.0)
        return label
    }()
    
    let newCanvasButton: UIButton = {
        let button = UIButton(title: "New canvas".localized)
        button.addTarget(self, action: #selector(handleNewCanvas), for: .touchUpInside)
        return button
    }()
    
    let myCollectionButton: UIButton = {
        let button = UIButton(title: "Collection".localized)
        button.addTarget(self, action: #selector(handleMyCollection), for: .touchUpInside)
        return button
    }()
    
    @objc func handleNewCanvas() {
        newCanvasAction?()
    }
    
    @objc func handleMyCollection() {
        myCollectionAction?()
    }
    
    func setup() {
        
        addSubview(backgroundImageView)
        backgroundImageView.pinToEdges(view: self, safe: false)
        
        addSubview(topContainer)
        topContainer.setAnchor(top: topAnchor, leading: leadingAnchor, bottom: nil, trailing: trailingAnchor, paddingTop: 0, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: CGFloat(Device.SCREEN_WIDTH), height: CGFloat(Device.SCREEN_HEIGHT/2))
        
        let titlesStackView = createStackView(views: [titleLabel, subtitleLabel], spacing: 0)
        topContainer.addSubview(titlesStackView)
        titlesStackView.setAnchor(width: self.frame.width, height: Device.IS_IPHONE ? 130 : 260)
        titlesStackView.centerXAnchor.constraint(equalTo: self.centerXAnchor).isActive = true
        titlesStackView.centerYAnchor.constraint(equalTo: topContainer.centerYAnchor).isActive = true
        
        
        addSubview(bottomContainer)
        bottomContainer.setAnchor(top: topContainer.bottomAnchor, leading: leadingAnchor, bottom: bottomAnchor, trailing: trailingAnchor, paddingTop: 0, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: CGFloat(Device.SCREEN_WIDTH), height: 0)
        
        //
        
        let titles2StackView = createStackView(views: [newCanvasButton, myCollectionButton], spacing: 0)
        bottomContainer.addSubview(titles2StackView)
        titles2StackView.setAnchor(width: self.frame.width, height: Device.IS_IPHONE ? 130 : 260)
        titles2StackView.centerXAnchor.constraint(equalTo: self.centerXAnchor).isActive = true
        titles2StackView.centerYAnchor.constraint(equalTo: bottomContainer.centerYAnchor).isActive = true
        
        //
        
        let buttonsStackView = createStackView(views: [newCanvasButton, myCollectionButton], spacing: Device.IS_IPHONE ? 10 : 40)
        bottomContainer.addSubview(buttonsStackView)
        buttonsStackView.backgroundColor = UIColor.lightGray
        
        buttonsStackView.setAnchor(width: self.frame.width - kStackViewMargin, height: kButtonsStackViewHeight)
        buttonsStackView.centerXAnchor.constraint(equalTo: self.centerXAnchor).isActive = true
        buttonsStackView.centerYAnchor.constraint(equalTo: bottomContainer.centerYAnchor).isActive = true
    }
}
