//
//  MyCanvasesController.swift
//  Fantasia
//
//  Created by Sebastian Strus on 2019-02-03.
//  Copyright © 2019 Sebastian Strus. All rights reserved.
//

import UIKit

class MyCanvasesController: UIViewController {
    
    
    var myCanvasesView: MyCanvasesView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
    }
    
    func setupView() {
        self.myCanvasesView = MyCanvasesView(frame: self.view.frame)
        self.view.addSubview(myCanvasesView)
        myCanvasesView.setAnchor(top: view.topAnchor,
                                leading: view.leadingAnchor,
                                bottom: view.bottomAnchor,
                                trailing: view.trailingAnchor,
                                paddingTop: 0,
                                paddingLeft: 0,
                                paddingBottom: 0,
                                paddingRight: 0)
    }
}
