//
//  MainMenuView.swift
//  Fantasia
//
//  Created by Sebastian Strus on 2019-02-01.
//  Copyright © 2019 Sebastian Strus. All rights reserved.
//


import UIKit

class MainMenuView: UIView {
    
    // MARK: - Initializers
    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Public actions
    var newCanvasAction: (() -> Void)?
    var galleryAction: (() -> Void)?
    
    // MARK: - All subviews
    fileprivate var backgroundImageView: UIImageView = {
        let iv = UIImageView(image: UIImage(named: "aurora1"))
        iv.backgroundColor = .white
        iv.contentMode = .scaleAspectFill
        return iv
    }()
    
    fileprivate var topContainer: UIView = {
        let view = UIView()
        return view
    }()
    
    fileprivate var bottomContainer: UIView = {
        let view = UIView()
        return view
    }()
    
    fileprivate let titleLabel: UILabel = {
        let label = UILabel()
        let attributedString = NSMutableAttributedString(attributedString: NSAttributedString(string: Strings.APP_TITLE, attributes: [NSAttributedString.Key.font: AppFonts.TITLE_FONT!, .foregroundColor: UIColor.white]))
        label.attributedText = attributedString
        label.textAlignment = NSTextAlignment.center
        label.shadowColor = .black
        label.shadowOffset = CGSize(width: 2.0, height: 2.0)
        return label
    }()
    
    fileprivate let subtitleLabel: UILabel = {
        let label = UILabel()
        let attributedString = NSMutableAttributedString(attributedString: NSAttributedString(string:  Strings.APP_SUBTITLE, attributes: [NSAttributedString.Key.font: AppFonts.SUBTITLE_FONT!, .foregroundColor: UIColor.white]))
        label.attributedText = attributedString
        label.textAlignment = NSTextAlignment.center
        label.shadowColor = .black
        label.shadowOffset = CGSize(width: 2.0, height: 2.0)
        return label
    }()
    
    fileprivate var buttonsStackView: UIStackView!
    
    fileprivate let newCanvasButton: BounceButton = {
        let button = BounceButton(title: "New canvas".localized)
        button.addTarget(self, action: #selector(handleNewCanvas), for: .touchUpInside)
        return button
    }()
    
    fileprivate let galleryButton: BounceButton = {
        let button = BounceButton(title: "Gallery".localized)
        button.addTarget(self, action: #selector(handleGallery), for: .touchUpInside)
        return button
    }()
    
    // MARK: - private functions
    fileprivate func setup() {
        addSubview(backgroundImageView)
        backgroundImageView.pinToEdges(view: self, safe: false)
        
        addSubview(topContainer)
        topContainer.setAnchor(top: topAnchor,
                               leading: leadingAnchor,
                               bottom: nil,
                               trailing: trailingAnchor,
                               paddingTop: 0,
                               paddingLeft: 0,
                               paddingBottom: 0,
                               paddingRight: 0,
                               width: CGFloat(Device.SCREEN_WIDTH),
                               height: CGFloat(Device.SCREEN_HEIGHT/2))
        
        let titlesStackView = createVerticalStackView(views: [titleLabel, subtitleLabel],
                                              spacing: Device.IS_IPHONE ? 20 : 40)
        topContainer.addSubview(titlesStackView)
        titlesStackView.setAnchor(width: self.frame.width,
                                  height: Device.IS_IPHONE ? 110 : 220)
        titlesStackView.centerXAnchor.constraint(equalTo: self.centerXAnchor).isActive = true
        titlesStackView.centerYAnchor.constraint(equalTo: topContainer.centerYAnchor).isActive = true
        
        addSubview(bottomContainer)
        bottomContainer.setAnchor(top: topContainer.bottomAnchor,
                                  leading: leadingAnchor,
                                  bottom: bottomAnchor,
                                  trailing: trailingAnchor,
                                  paddingTop: 0,
                                  paddingLeft: 0,
                                  paddingBottom: 0,
                                  paddingRight: 0,
                                  width: CGFloat(Device.SCREEN_WIDTH),
                                  height: 0)
        
        
        
        buttonsStackView = createVerticalStackView(views: [newCanvasButton, galleryButton],
                                               spacing: Device.IS_IPHONE ? 15 : 30)
        bottomContainer.addSubview(buttonsStackView)
        buttonsStackView.setAnchor(width: Device.IS_IPHONE ? 200 : 400,
                                   height: Device.IS_IPHONE ? 115 : 230)
        buttonsStackView.centerXAnchor.constraint(equalTo: self.centerXAnchor).isActive = true
        buttonsStackView.centerYAnchor.constraint(equalTo: bottomContainer.centerYAnchor).isActive = true
        
        titleLabel.alpha = 0
        subtitleLabel.alpha = 0
        buttonsStackView.alpha = 0
        showTitle()
    }

    func showTitle(){
        UIView.animate(withDuration: 1, animations: {
            self.titleLabel.alpha = 1
        }, completion: { (true) in
            self.showSubtitle()
        })
        
    }
    
    func showSubtitle() {
        UIView.animate(withDuration: 1, animations: {
            self.subtitleLabel.alpha = 1
        }) { (true) in
            self.showButtons()
        }
    }
    
    func showButtons() {
        UIView.animate(withDuration: 1) {
            self.buttonsStackView.alpha = 1
        }
    }
    
    @objc fileprivate func handleNewCanvas() {
        newCanvasAction?()
    }
    
    @objc fileprivate func handleGallery() {
        galleryAction?()
    }
}
