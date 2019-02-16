//
//  NewCanvasController.swift
//  Fantasia
//
//  Created by Sebastian Strus on 2019-02-03.
//  Copyright © 2019 Sebastian Strus. All rights reserved.
//

import UIKit
import AVFoundation

class CanvasController: UIViewController, ColorDelegate {
    
    let varietiesViewController = VarietiesViewController()
    
    var canvasActivityView: CanvasView!
    
    func onGetColor(color: UIColor) {
        canvasActivityView.setColor(color: color)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        hideKeyboardWhenTappedAround()
        
        setupLayout()
        varietiesViewController.delegate = self
        
    }
    
    fileprivate func setupLayout() {
        view.backgroundColor = AppColors.WHITE_GRAY
        canvasActivityView = CanvasView()
        view.addSubview(canvasActivityView)
        canvasActivityView.pinToEdges(view: view, safe: true)
        
        canvasActivityView.changeColorAction = handleChangeColor
        canvasActivityView.backAction = handleBack
        canvasActivityView.saveCanvasAction = handleSaveCanvas
    }
    
    func handleChangeColor() {
        present(varietiesViewController, animated: true, completion: nil)
    }
    
    func handleBack() {
        dismiss(animated: true, completion: nil)
    }
    
    func handleSaveCanvas() {
        canvasActivityView.saveCanvas()
        dismiss(animated: true, completion: nil)
    }
}

protocol ColorDelegate
{
    func onGetColor(color: UIColor)
}
