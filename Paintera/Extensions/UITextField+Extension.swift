//
//  UITextField+Extension.swift
//  Paintera
//
//  Created by Sebastian Strus on 2019-02-24.
//  Copyright © 2019 Sebastian Strus. All rights reserved.
//

import UIKit

extension UITextField {
    func setLeftPaddiingPoints(_ space: CGFloat) {
        let paddingView = UIView(frame: CGRect(x: 0, y: 0, width: space, height: self.frame.size.height))
        self.leftView = paddingView
        self.leftViewMode = .always
    }
}
