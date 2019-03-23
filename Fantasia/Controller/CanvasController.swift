//
//  NewCanvasController.swift
//  Fantasia
//
//  Created by Sebastian Strus on 2019-02-03.
//  Copyright © 2019 Sebastian Strus. All rights reserved.
//

import UIKit
import AVFoundation

class CanvasController: UIViewController, UIImagePickerControllerDelegate, UIPickerViewDelegate, UINavigationControllerDelegate, UIPopoverPresentationControllerDelegate, PopupDelegate {
    
    
    let savePopupController = SavePopupController()
    
    func onGotTitle(title: String) {
        CanvasObjectController.shared.saveCanvasObject(image: canvasActivityView.correctCanvasView.asImage(), title: title, date: Date())
        navigationController?.popViewController(animated: true)
    }
    
    public var canvasActivityView: CanvasView!
    fileprivate var canvas: CanvasObject?
    

 
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        navigationController?.fixNavigationItemsMargin(Device.IS_IPHONE ? 8 : 16)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        navigationController?.fixNavigationItemsMargin(Device.IS_IPHONE ? 8 : 16)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        hideKeyboardWhenTappedAround()
        setupNavigationBar()
        setupLayout()
    }

    
    fileprivate func setupNavigationBar() {
        let libraryButton: UIButton = {
            let button = UIButton(type: .custom)
            button.setImage(UIImage(named: "library_icon"), for: .normal)
            button.addTarget(self, action: #selector(handleLibrary), for: .touchUpInside)
            return button
        }()
        
        let saveButton: UIButton = {
            let button = UIButton(type: .system)
            button.tintColor = UIColor.white
            button.setImage(UIImage(named: "button_save"), for: .normal)
            button.addTarget(self, action: #selector(handlePopup), for: .touchUpInside)
            return button
        }()
        
        let libraryItem = UIBarButtonItem(customView: libraryButton)
        libraryItem.customView?.widthAnchor.constraint(equalToConstant: 33).isActive = true//ipad 50
        libraryItem.customView?.heightAnchor.constraint(equalToConstant: 44).isActive = true
        
        
        let saveItem = UIBarButtonItem(customView: saveButton)
        saveItem.customView?.widthAnchor.constraint(equalToConstant: 33).isActive = true
        saveItem.customView?.heightAnchor.constraint(equalToConstant: 44).isActive = true
        //let spacer = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
        
        libraryItem.customView?.trailingAnchor.constraint(equalTo: libraryItem.customView!.leadingAnchor, constant: 0).isActive = true
        self.navigationItem.rightBarButtonItems = [saveItem, libraryItem]
    }
    
    fileprivate func setupLayout() {
        
        savePopupController.popupDelegate = self
    
        canvasActivityView = CanvasView()
        view.addSubview(canvasActivityView)
        
        canvasActivityView.setAnchor(top: view.safeTopAnchor, leading: view.leadingAnchor, bottom: view.bottomAnchor, trailing: view.trailingAnchor, paddingTop:0, paddingLeft: 0, paddingBottom: 0, paddingRight: 0)
        
        canvasActivityView.libraryAction = handleLibrary
        
        if let canvas = canvas {
            canvasActivityView.setCanvas(canvas: canvas)
        }
        

    }
    


    @objc func handlePopup() {
        savePopupController.modalPresentationStyle = UIModalPresentationStyle.overCurrentContext
        present(savePopupController, animated: false)
        
//        if let pop = savePopupController.popoverPresentationController {
//            pop.delegate = self
//        }
        
        
        
    }
    

    
    @objc fileprivate func handleLibrary() {
        print("handleLibrary")
        if UIImagePickerController.isSourceTypeAvailable(UIImagePickerController.SourceType.photoLibrary) {
            let imagePicker = UIImagePickerController()
            imagePicker.delegate = self
            imagePicker.sourceType = UIImagePickerController.SourceType.photoLibrary;
            imagePicker.allowsEditing = false
            self.present(imagePicker, animated: true, completion: nil)
        }
    }
    
    // MARK: - UIImagePickerControllerDelegate functions
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        var selectedImageFromPicker: UIImage?
        if let editedImage = info[.editedImage] as? UIImage {
            selectedImageFromPicker = editedImage
        } else if let originalImage = info[.originalImage] as? UIImage {
            selectedImageFromPicker = originalImage
        }
        if let selectedImage = selectedImageFromPicker {
            canvasActivityView.setImage(image: selectedImage)
        }
        picker.dismiss(animated: true)
    }
    
    // MARK: - Public functions
    func setCanvas(canvas: CanvasObject) {
        self.canvas = canvas
    }
}


class WrapperView: UIView {
    let minimumSize: CGSize = CGSize(width: 44.0, height: 44.0)
    let underlyingView: UIView
    init(underlyingView: UIView) {
        self.underlyingView = underlyingView
        super.init(frame: underlyingView.bounds)
        
        underlyingView.translatesAutoresizingMaskIntoConstraints = false
        addSubview(underlyingView)
        
        NSLayoutConstraint.activate([
            underlyingView.leadingAnchor.constraint(equalTo: leadingAnchor),
            underlyingView.trailingAnchor.constraint(equalTo: trailingAnchor),
            underlyingView.topAnchor.constraint(equalTo: topAnchor),
            underlyingView.bottomAnchor.constraint(equalTo: bottomAnchor),
            heightAnchor.constraint(greaterThanOrEqualToConstant: minimumSize.height),
            widthAnchor.constraint(greaterThanOrEqualToConstant: minimumSize.width)
            ])
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
