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
    
    func onGetColor(color: UIColor) {
        canvas.setStrokeColor(color: color)
    }
    
    
    
    var canvas = CanvasView()
    
    let undoButton: UIButton = {
        let button = UIButton(type: .system)
        button.setImage(UIImage(named: "btn_undo"), for: .normal)
        button.titleLabel?.font = .boldSystemFont(ofSize: 14)
        button.addTarget(self, action: #selector(handleUndo), for: .touchUpInside)
        return button
    }()
    
    @objc fileprivate func handleUndo() {
        canvas.undo()
    }
    
    @objc fileprivate func handleClear() {
        canvas.clear()
    }
    
    let clearButton: UIButton = {
        let button = UIButton(type: .system)
        button.setImage(UIImage(named: "btn_clear"), for: .normal)
        button.titleLabel?.font = .boldSystemFont(ofSize: 14)
        button.addTarget(self, action: #selector(handleClear), for: .touchUpInside)
        return button
    }()
    
    override func loadView() {
        view = canvas
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupLayout()
        varietiesViewController.delegate = self
    }
    
    fileprivate func setupLayout() {
        canvas.changeColorAction = handleChangeColor
        
        view.addSubview(undoButton)
        undoButton.setAnchor(top: view.safeTopAnchor, leading: view.leadingAnchor, bottom: nil, trailing: nil, paddingTop: 5, paddingLeft: 20, paddingBottom: 0, paddingRight: 0, width: 40, height: 40)
        
        view.addSubview(clearButton)
        clearButton.setAnchor(top: view.safeTopAnchor, leading: nil, bottom: nil, trailing: view.safeTrailingAnchor, paddingTop: 5, paddingLeft: 0, paddingBottom: 0, paddingRight: 20, width: 40, height: 40)
    }
    
    func handleChangeColor() {
        present(varietiesViewController, animated: true, completion: nil)
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
