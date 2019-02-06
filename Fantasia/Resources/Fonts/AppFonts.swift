//
//  AppFonts.swift
//  Fantasia
//
//  Created by Sebastian Strus on 2019-02-02.
//  Copyright © 2019 Sebastian Strus. All rights reserved.
//

import UIKit

struct AppFonts {
    static let TITLE_FONT = UIFont(name: "LuckiestGuy-Regular", size: Device.IS_IPHONE ? 75 : 150)
    static let SUBTITLE_FONT = UIFont(name: "Oswald-Medium", size: Device.IS_IPHONE ? 40 : 80)
    static let BTN_FONT = UIFont(name: "SeymourOne", size: Device.IS_IPHONE ? 20 : 40)
    static let BTN_COLOR_FONT = UIFont(name: "LondrinaOutline-Regular", size: Device.IS_IPHONE ? 50 : 100)
    static let NAV_BAR_FONT = UIFont(name: "Georgia-Bold", size: Device.IS_IPHONE ? 24 : 40)
    static let LIST_CELL_FONT = UIFont.boldSystemFont(ofSize: Device.IS_IPHONE ? 26 : 52)
    static let LIST_CELL_DISTANCE_FONT = UIFont.systemFont(ofSize: Device.IS_IPHONE ? 13 : 26)
}
