//
//  NewCanvasController.swift
//  Fantasia
//
//  Created by Sebastian Strus on 2019-02-03.
//  Copyright © 2019 Sebastian Strus. All rights reserved.
//

import UIKit

class CanvasController: UIViewController, ColorDelegate {
    
    
    let varietiesViewController = VarietiesViewController()
    
    var canvasActivityView = CanvasView()
    
    func onGetColor(color: UIColor) {
        canvasActivityView.setColor(color: color)
    }
    
    override func loadView() {
        view = canvasActivityView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupLayout()
        varietiesViewController.delegate = self
    }
    
    fileprivate func setupLayout() {
        canvasActivityView.changeColorAction = handleChangeColor
        canvasActivityView.saveCanvasAction = handleSaveCanvas
    }
    
    func handleChangeColor() {
        present(varietiesViewController, animated: true, completion: nil)
    }
    
    func handleSaveCanvas() {
        canvasActivityView.saveCanvas()
    }
    
    func pickColor(color: UIColor) {
//        print("Print 2:")
//        print(color)
//        canvas.setColor(color: color)
    }

}


protocol ColorDelegate
{
    func onGetColor(color: UIColor)
}
