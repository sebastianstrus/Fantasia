//
//  BounceButton.swift
//  Paintera
//
//  Created by Sebastian Strus on 2019-03-27.
//  Copyright © 2019 Sebastian Strus. All rights reserved.
//

import UIKit

class BounceButton: UIButton {

    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.transform = CGAffineTransform(scaleX: 1.1, y: 1.1)
        
        UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 0.5, initialSpringVelocity: 6, options: .allowUserInteraction, animations: {
            self.transform = CGAffineTransform.identity
        })
        super.touchesBegan(touches, with: event)
    }
}
