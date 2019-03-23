//
//  SavePopupController.swift
//  Fantasia
//
//  Created by Sebastian Strus on 2019-03-21.
//  Copyright © 2019 Sebastian Strus. All rights reserved.
//

import UIKit

class SavePopupController: UIViewController {
    
    var savePopupView: SavePopupView!
    
    var popupDelegate: PopupDelegate?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        setup()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        savePopupView.animate()
    }
    
    
    func setup() {
        
        savePopupView = SavePopupView()
        view.addSubview(savePopupView)
        savePopupView.pinToEdges(view: view, safe: false)
        
        savePopupView.cancelAction = handleCancel
        savePopupView.saveAction = handleSave
        //savePopupView.animate()
    }
    
    
    func handleCancel() {
        dismiss(animated: false)
    }
    
    func handleSave(title: String) {
        print("My title: \(title)")
        popupDelegate?.onGotTitle(title: title)
        dismiss(animated: true)
    }
}


protocol PopupDelegate {
    func onGotTitle(title: String)
}
