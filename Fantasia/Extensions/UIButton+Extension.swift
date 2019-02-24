//
//  UIButton+Extension.swift
//  Fantasia
//
//  Created by Sebastian Strus on 2019-02-02.
//  Copyright © 2019 Sebastian Strus. All rights reserved.
//

import UIKit

extension UIButton {
    
    public convenience init(title: String) {
        self.init()
        let attributedString = NSMutableAttributedString(attributedString: NSAttributedString(string: title, attributes: [NSAttributedString.Key.font: AppFonts.BTN_FONT!, .foregroundColor: AppColors.BUTTON_TITLE]))
        self.setAttributedTitle(attributedString, for: .normal)
        self.layer.cornerRadius = Device.IS_IPHONE ? 20 : 40
        self.backgroundColor = AppColors.TRANSPARENT_BLACK
        self.setAnchor(width: Device.IS_IPHONE ? 180 : 360,
                       height: Device.IS_IPHONE ? 40 : 80)
    }

}
