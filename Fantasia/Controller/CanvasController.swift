//
//  NewCanvasController.swift
//  Fantasia
//
//  Created by Sebastian Strus on 2019-02-03.
//  Copyright © 2019 Sebastian Strus. All rights reserved.
//

import UIKit
import AVFoundation

class CanvasController: UIViewController {
    
    fileprivate var canvasActivityView: CanvasView!
    
    fileprivate func onGetColor(color: UIColor) {
        canvasActivityView.setColor(color: color)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        hideKeyboardWhenTappedAround()
        
        setupLayout()
    }
    
    fileprivate func setupLayout() {
        view.backgroundColor = AppColors.WHITE_GRAY
        canvasActivityView = CanvasView()
        view.addSubview(canvasActivityView)
        canvasActivityView.pinToEdges(view: view, safe: false)
        
        canvasActivityView.backAction = handleBack
        canvasActivityView.saveCanvasAction = handleSaveCanvas
    }
    

    
    fileprivate func handleBack() {
        dismiss(animated: true, completion: nil)
    }
    
    fileprivate func handleSaveCanvas() {
        canvasActivityView.saveCanvas()
        dismiss(animated: true, completion: nil)
    }
}
