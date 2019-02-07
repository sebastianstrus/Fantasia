//
//  MainMenuView.swift
//  Fantasia
//
//  Created by Sebastian Strus on 2019-02-01.
//  Copyright © 2019 Sebastian Strus. All rights reserved.
//


import UIKit

let kButtonsStackViewHeight: CGFloat = Device.IS_IPHONE ? 140 : 280
let kStackViewMargin: CGFloat = Device.IS_IPHONE ? 120 : 300

class MainMenuView: UIView {
    
    var newCanvasAction: (() -> Void)?
    var myCanvasesAction: (() -> Void)?
    
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
        button.addTarget(self, action: #selector(handleNewDrawing), for: .touchUpInside)
        return button
    }()
    
    let myCanvasesButton: UIButton = {
        let button = UIButton(title: "My canvases".localized)
        button.addTarget(self, action: #selector(handleMyDrawings), for: .touchUpInside)
        return button
    }()
    
    @objc func handleNewDrawing() {
        newCanvasAction?()
    }
    
    @objc func handleMyDrawings() {
        myCanvasesAction?()
    }
    
    func setup() {
        addSubview(backgroundImageView)
        
        let titlesStackView = createStackView(views: [titleLabel, subtitleLabel], spacing: 0)
        addSubview(titlesStackView)
        titlesStackView.setAnchor(top: topAnchor,
                                  leading: nil,
                                  bottom: nil,
                                  trailing: nil,
                                  paddingTop: Device.IS_IPHONE ? 180 : 360,
                                  paddingLeft: 0,
                                  paddingBottom: 0,
                                  paddingRight: 0,
                                  width: self.frame.width,
                                  height: Device.IS_IPHONE ? 130 : 260)
        titlesStackView.centerXAnchor.constraint(equalTo: self.centerXAnchor).isActive = true
        
        let buttonsStackView = createStackView(views: [newCanvasButton, myCanvasesButton], spacing: Device.IS_IPHONE ? 20 : 40)
        addSubview(buttonsStackView)
        backgroundImageView.setAnchor(top: self.topAnchor,
                                      leading: self.leadingAnchor,
                                      bottom: self.bottomAnchor,
                                      trailing: self.trailingAnchor,
                                      paddingTop: 0,
                                      paddingLeft: 0,
                                      paddingBottom: 0,
                                      paddingRight: 0)
        
        buttonsStackView.setAnchor(top: nil,
                            leading: nil,
                            bottom: nil,
                            trailing: nil,
                            paddingTop: 0,
                            paddingLeft: 0,
                            paddingBottom: 0,
                            paddingRight: 0,
                            width: self.frame.width - kStackViewMargin,
                            height: kButtonsStackViewHeight)
        buttonsStackView.centerYAnchor.constraint(equalTo: self.centerYAnchor).isActive = true
        buttonsStackView.centerXAnchor.constraint(equalTo: self.centerXAnchor).isActive = true
    }
}
