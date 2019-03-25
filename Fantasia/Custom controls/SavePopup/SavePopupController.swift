//
//  SavePopupController.swift
//  Fantasia
//
//  Created by Sebastian Strus on 2019-03-21.
//  Copyright © 2019 Sebastian Strus. All rights reserved.
//

import UIKit

protocol PopupDelegate {
    func onGotTitle(title: String, keepPrevious: Bool)
}

class SavePopupController: UIViewController {
    
    var savePopupView: SavePopupView!
    var popupDelegate: PopupDelegate?
    var canvasTitle: String?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //hideKeyboardWhenTappedAround()
        
        setup()
        
        NotificationCenter.default.addObserver(self,
                                               selector: #selector(keyboardWillShow),
                                               name: UIResponder.keyboardWillShowNotification,
                                               object: nil)
        NotificationCenter.default.addObserver(self,
                                               selector: #selector(keyboardWillHide),
                                               name: UIResponder.keyboardWillHideNotification,
                                               object: nil)
        

    }
    
    

    @objc func keyboardWillShow(_ notification: Notification) {
        savePopupView.handleKeyboardUp()
    }
    
    @objc func keyboardWillHide(notification: NSNotification) {
        savePopupView.handleKeyboardDown()
    }

    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        savePopupView.animate()
    }
    
    // MARK: - Private functions
    fileprivate func setup() {
        savePopupView = SavePopupView(isEditing: isEditing, title: canvasTitle)
        view.addSubview(savePopupView)
        savePopupView.pinToEdges(view: view, safe: false)
        savePopupView.cancelAction = handleCancel
        savePopupView.saveAction = handleSave
    }
    
    fileprivate func handleCancel() {
        dismiss(animated: false)
    }
    
    fileprivate func handleSave(title: String) {
        popupDelegate?.onGotTitle(title: title, keepPrevious: savePopupView.getKeepPrevious())
        dismiss(animated: true)
    }
    
    public func setEditing(isEditing: Bool) {
        savePopupView.isEditing = isEditing
    }
}
