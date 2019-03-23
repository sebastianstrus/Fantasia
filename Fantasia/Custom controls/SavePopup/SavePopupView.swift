//
//  SavePopupView.swift
//  Fantasia
//
//  Created by Sebastian Strus on 2019-02-23.
//  Copyright © 2019 Sebastian Strus. All rights reserved.
//

import UIKit

class SavePopupView: UIView {
    
    //var popupDelegate: PopupDelegate?
    
    // MARK: - Public actions
    var saveAction: ((_ title: String) -> Void)?
    var cancelAction: (() -> Void)?
    
    fileprivate let blurView: UIVisualEffectView  = {
        let view = UIVisualEffectView (effect: nil)
        return view
    }()
    
    fileprivate let savingView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor.clear
        return view
    }()
    
    
    // TODO: add shadow/opacity/ alpha 0.84
    fileprivate let popupView: UIView = {
        let view = UIView()
        view.layer.cornerRadius = Device.IS_IPHONE ? 10 : 20
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
        label.font = UIFont.systemFont(ofSize: Device.IS_IPHONE ? 15 : 30)
        return label
    }()
    
    fileprivate let textField: UITextField = {
        let tf = UITextField()
        tf.font = UIFont.systemFont(ofSize: Device.IS_IPHONE ?  12 : 24)
        tf.placeholder = "Enter title"
        tf.layer.borderWidth = 0.5
        tf.layer.borderColor = AppColors.DODGERBLUE.cgColor
        tf.setLeftPaddiingPoints(Device.IS_IPHONE ? 10 : 20)
        return tf
    }()
    
    fileprivate let cancelButton: UIButton = {
        let button = UIButton()
        button.setTitle("Cancel", for: .normal)
        button.setTitleColor(AppColors.DODGERBLUE, for: .normal)
        button.layer.borderWidth = 0.5
        button.titleLabel?.font = UIFont.systemFont(ofSize: Device.IS_IPHONE ? 12 : 24)
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
        button.titleLabel?.font = UIFont.systemFont(ofSize: Device.IS_IPHONE ? 12 : 24)
        button.layer.borderColor = AppColors.DODGERBLUE.cgColor
        button.addTarget(self, action: #selector(handleOk), for: .touchUpInside)
        return button
    }()
    
    
    
    
    
    
    
    
    // MARK: - Initializers
    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    

    fileprivate func setup() {
        addSubview(blurView)
        blurView.pinToEdges(view: self, safe: false)
        blurView.effect = nil
    
        addSubview(savingView)
        savingView.pinToEdges(view: self, safe: false)

        savingView.addSubview(popupView)
        popupView.setAnchor(width: Device.IS_IPHONE ? 200 : 400, height: Device.IS_IPHONE ? 100 : 200)

        popupView.centerXAnchor.constraint(equalTo: savingView.centerXAnchor).isActive = true
        popupView.centerYAnchor.constraint(equalTo: savingView.centerYAnchor).isActive = true

        popupView.addSubview(headerLabel)
        headerLabel.setAnchor(top: popupView.topAnchor, leading: popupView.leadingAnchor, bottom: nil, trailing: popupView.trailingAnchor, paddingTop: 0, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: 0, height: Device.IS_IPHONE ? 30 : 60)

        popupView.addSubview(textField)
        textField.setAnchor(top: headerLabel.bottomAnchor, leading: popupView.leadingAnchor, bottom: nil, trailing: popupView.trailingAnchor, paddingTop: 0, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: 0, height: Device.IS_IPHONE ?  40 : 80)

        popupView.addSubview(cancelButton)
        cancelButton.setAnchor(top: textField.bottomAnchor, leading: popupView.leadingAnchor, bottom: popupView.bottomAnchor, trailing: nil, paddingTop: 0, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: Device.IS_IPHONE ? 100 : 200, height: 0)

        popupView.addSubview(okButton)
        okButton.setAnchor(top: textField.bottomAnchor, leading: nil, bottom: popupView.bottomAnchor, trailing: popupView.trailingAnchor, paddingTop: 0, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: Device.IS_IPHONE ? 100 : 200, height: 0)


        popupView.alpha = 0
        popupView.transform = CGAffineTransform.init(scaleX: 2, y: 2)

    }

    
    @objc fileprivate func handleCancel() {
        UIView.animate(withDuration: 0.4, animations: {
            self.blurView.effect = nil
            self.popupView.alpha = 0
            self.popupView.transform = CGAffineTransform.init(scaleX: 2, y: 2)
        }) { _ in
            self.cancelAction!()
        }
    }
    
    @objc fileprivate func handleOk() {
        if let title = textField.text, !title.isEmpty {
            UIView.animate(withDuration: 0.4, animations: {
                self.blurView.effect = nil
                self.popupView.alpha = 0
                self.popupView.transform = CGAffineTransform.init(scaleX: 2, y: 2)
            }) { _ in
                self.saveAction!(title)
            }
        }
    }
    
    public func animate() {
        UIView.animate(withDuration: 0.4) {
            self.blurView.effect = UIBlurEffect(style: .light)
            self.popupView.alpha = 1
            self.popupView.transform = CGAffineTransform.identity
        }
    }
}


