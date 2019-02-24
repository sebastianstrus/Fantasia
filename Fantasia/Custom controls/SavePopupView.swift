//
//  SavePopupView.swift
//  Fantasia
//
//  Created by Sebastian Strus on 2019-02-23.
//  Copyright © 2019 Sebastian Strus. All rights reserved.
//

import UIKit

class SavePopupView: UIView {
    
    // MARK: - Initializers
    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    // MARK: - All subviews
    let popupView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor.white
        view.layer.cornerRadius = Device.IS_IPHONE ? 10 : 20
        return view
    }()
    
    // over current context
    fileprivate func setup() {
        backgroundColor = AppColors.TRANSPARENT_BLACK
        addSubview(popupView)
        popupView.setAnchor(width: 400, height: 300)
        popupView.centerXAnchor.constraint(equalTo: centerXAnchor).isActive = true
        popupView.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true
    }

}

