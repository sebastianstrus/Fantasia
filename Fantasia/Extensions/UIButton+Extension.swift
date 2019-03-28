//
//  UIButton+Extension.swift
//  Fantasia
//
//  Created by Sebastian Strus on 2019-02-02.
//  Copyright © 2019 Sebastian Strus. All rights reserved.
//

import UIKit

extension BounceButton {
    
    public convenience init(title: String) {
        self.init()
        let attributedString = NSMutableAttributedString(attributedString: NSAttributedString(string: title, attributes: [NSAttributedString.Key.font: AppFonts.BTN_FONT!, .foregroundColor: AppColors.BUTTON_TITLE]))
        self.setAttributedTitle(attributedString, for: .normal)
        self.layer.cornerRadius = Device.IS_IPHONE ? 25 : 50
        self.layer.borderColor = UIColor.white.cgColor
        self.layer.borderWidth = 2
        self.backgroundColor = AppColors.TRANSPARENT_BLACK
        self.setAnchor(width: Device.IS_IPHONE ? 200 : 400,
                       height: Device.IS_IPHONE ? 50 : 100)
    }
    
    

}
