//
//  SavePopupView.swift
//  Paintera
//
//  Created by Sebastian Strus on 2019-02-23.
//  Copyright © 2019 Sebastian Strus. All rights reserved.
//

import UIKit

class SavePopupView: UIView {
    
    var saveAction: ((_ title: String) -> Void)?
    var cancelAction: (() -> Void)?
    var isEditing: Bool!
    var title: String?
    
    var yCenterAnchor: NSLayoutConstraint!
    var yUpAnchor: NSLayoutConstraint!
    
    // MARK: - Initializers
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    convenience init(isEditing: Bool, title: String?) {
        self.init(frame: .zero)
        self.isEditing = isEditing
        self.title = title
        setup()
    }
    
    
    
    

    fileprivate let blurView: UIVisualEffectView  = {
        let view = UIVisualEffectView (effect: nil)
        return view
    }()
    
    fileprivate let popupView: UIView = {
        let view = UIView()
        view.layer.cornerRadius = 10
        view.clipsToBounds = true
        view.backgroundColor = UIColor.white
        view.layer.borderWidth = 2
        view.layer.borderColor = AppColors.DODGERBLUE.cgColor
        return view
    }()
    
    fileprivate let headerLabel: UILabel = {
        let label = UILabel()
        label.backgroundColor = AppColors.DODGERBLUE
        label.textColor = UIColor.white
        label.textAlignment = .center
        label.text = "Save canvas"
        label.font = UIFont.boldSystemFont(ofSize: 16)
        return label
    }()
    
    fileprivate let titleTF: UITextField = {
        let tf = UITextField()
        tf.font = UIFont.boldSystemFont(ofSize: 15)
        tf.placeholder = "Enter title"
        tf.autocorrectionType = UITextAutocorrectionType.no
        tf.textColor = UIColor.darkGray
        tf.textAlignment = .center
        tf.layer.borderWidth = 0.5
        tf.layer.borderColor = AppColors.DODGERBLUE.cgColor
        tf.setLeftPaddiingPoints(10)
        return tf
    }()
    
    fileprivate let switchButton: UISwitch = {
        let sw = UISwitch()
        sw.onTintColor = AppColors.DODGERBLUE
        return sw
    }()
    
    fileprivate let switchLabel: UILabel = {
        let label = UILabel()
        label.textColor = UIColor.black
        label.font = UIFont.systemFont(ofSize: 15)
        label.textColor = UIColor.darkGray
        label.text = "Keep previous version"
        return label
    }()
    
    fileprivate let cancelButton: UIButton = {
        let button = UIButton()
        button.setTitle("Cancel", for: .normal)
        button.setTitleColor(AppColors.DODGERBLUE, for: .normal)
        button.layer.borderWidth = 0.5
        button.titleLabel?.font = UIFont.systemFont(ofSize: 15)
        button.layer.borderColor = AppColors.DODGERBLUE.cgColor
        button.addTarget(self, action: #selector(handleCancel), for: .touchUpInside)
        return button
    }()
    
    fileprivate let okButton: UIButton = {
        let button = UIButton()
        button.setTitle("Save", for: .normal)
        button.setTitleColor(AppColors.DODGERBLUE, for: .normal)
        button.tintColor = AppColors.WHITE_GRAY
        button.layer.borderWidth = 0.5
        button.titleLabel?.font = UIFont.systemFont(ofSize: 15)
        button.layer.borderColor = AppColors.DODGERBLUE.cgColor
        button.addTarget(self, action: #selector(handleOk), for: .touchUpInside)
        return button
    }()
    
    // MARK: - Private functions
    fileprivate func setup() {
        
        
        addSubview(blurView)
        blurView.pinToEdges(view: self, safe: false)
        blurView.effect = nil
    
        addSubview(popupView)
        popupView.setAnchor(width: 240,
                            height: isEditing ? (160) : (120))


        popupView.centerXAnchor.constraint(equalTo: blurView.centerXAnchor).isActive = true
        yCenterAnchor = popupView.centerYAnchor.constraint(equalTo: blurView.centerYAnchor)
        yUpAnchor = popupView.centerYAnchor.constraint(equalTo: blurView.centerYAnchor, constant: -100)
        yCenterAnchor.isActive = true

        popupView.addSubview(headerLabel)
        headerLabel.setAnchor(top: popupView.topAnchor,
                              leading: popupView.leadingAnchor,
                              bottom: nil,
                              trailing: popupView.trailingAnchor,
                              paddingTop: 0,
                              paddingLeft: 0,
                              paddingBottom: 0,
                              paddingRight: 0,
                              width: 0,
                              height: 40)

        popupView.addSubview(titleTF)
        titleTF.setAnchor(top: headerLabel.bottomAnchor,
                            leading: popupView.leadingAnchor,
                            bottom: nil,
                            trailing: popupView.trailingAnchor,
                            paddingTop: 0,
                            paddingLeft: 0,
                            paddingBottom: 0,
                            paddingRight: 0,
                            width: 0,
                            height: 40)

        if (isEditing) {
            popupView.addSubview(switchButton)
            switchButton.setAnchor(top: titleTF.bottomAnchor,
                                   leading: popupView.leadingAnchor,
                                   bottom: nil,
                                   trailing: nil,
                                   paddingTop: 5,
                                   paddingLeft: 8,
                                   paddingBottom: 0,
                                   paddingRight: 5,
                                   width: 51,
                                   height: 31)
            
            popupView.addSubview(switchLabel)
            switchLabel.setAnchor(top: titleTF.bottomAnchor,
                                   leading: switchButton.trailingAnchor,
                                   bottom: nil,
                                   trailing: popupView.trailingAnchor,
                                   paddingTop: 5,
                                   paddingLeft: 8,
                                   paddingBottom: 5,
                                   paddingRight: 5,
                                   width: 0,
                                   height: 30)
            titleTF.text = title
        }
        
        popupView.addSubview(cancelButton)
        cancelButton.setAnchor(top: nil,
                               leading: popupView.leadingAnchor,
                               bottom: popupView.bottomAnchor,
                               trailing: nil,
                               paddingTop: 0,
                               paddingLeft: 0,
                               paddingBottom: 0,
                               paddingRight: 0,
                               width: 120,
                               height: 40)

        popupView.addSubview(okButton)
        okButton.setAnchor(top: nil,
                           leading: nil,
                           bottom: popupView.bottomAnchor,
                           trailing: popupView.trailingAnchor,
                           paddingTop: 0,
                           paddingLeft: 0,
                           paddingBottom: 0,
                           paddingRight: 0,
                           width: 120,
                           height: 40)

        popupView.alpha = 0
        popupView.transform = CGAffineTransform.init(scaleX: Device.IS_IPHONE ? 2 : 4, y: Device.IS_IPHONE ? 2 : 4)

    }
    
    @objc fileprivate func handleCancel() {
        endEditing(true)
        UIView.animate(withDuration: 0.4, animations: {
            self.blurView.effect = nil
            self.popupView.alpha = 0
            self.popupView.transform = CGAffineTransform.init(scaleX: Device.IS_IPHONE ? 2 : 4, y: Device.IS_IPHONE ? 2 : 4)
        }) { _ in
            self.cancelAction!()
        }
    }
    
    @objc fileprivate func handleOk() {
        endEditing(true)
        if let title = titleTF.text, !title.isEmpty {
            UIView.animate(withDuration: 0.4, animations: {
                self.blurView.effect = nil
                self.popupView.alpha = 0
                self.popupView.transform = CGAffineTransform.init(scaleX: Device.IS_IPHONE ? 2 : 4, y: Device.IS_IPHONE ? 2 : 4)
            }) { _ in
                self.saveAction!(title)
            }
        }
    }
    
    // MARK: - Public actions
    public func animate() {
        UIView.animate(withDuration: 0.4) {
            self.blurView.effect = UIBlurEffect(style: .light)
            self.popupView.alpha = 1
            self.popupView.transform = CGAffineTransform.identity
        }
    }
    
    public func getKeepPrevious() -> Bool {
        return switchButton.isOn
    }
    
    public func handleKeyboardUp() {
        self.yCenterAnchor.isActive = false
        self.yUpAnchor.isActive = true
        UIView.animate(withDuration: 0.4) {
            self.layoutIfNeeded()
        }
    }
    
    public func handleKeyboardDown() {
        self.yUpAnchor.isActive = false
        self.yCenterAnchor.isActive = true
        UIView.animate(withDuration: 0.4) {
            self.layoutIfNeeded()
        }
    }
}
