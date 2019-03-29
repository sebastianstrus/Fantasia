//
//  RoundViewExtension.swift
//  Fantasia
//
//  Created by Sebastian Strus on 2019-02-04.
//  Copyright © 2019 Sebastian Strus. All rights reserved.
//

import UIKit

extension UIView {
    
    // Circle view
    func circleStyledView() {
        self.layer.masksToBounds = true
        self.layer.cornerRadius  = round(self.frame.size.width/2.0)
    }
}
