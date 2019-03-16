//
//  NewCanvasController.swift
//  Fantasia
//
//  Created by Sebastian Strus on 2019-02-03.
//  Copyright © 2019 Sebastian Strus. All rights reserved.
//

import UIKit
import AVFoundation


/*enum State {
    case write
    case read
}*/

class CanvasController: UIViewController, UIImagePickerControllerDelegate, UIPickerViewDelegate, UINavigationControllerDelegate {
    
    //private var state = State.write
    
    public var canvasActivityView: CanvasView!
    fileprivate var canvas: CanvasObject?
    
   
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        print("viewWillAppear")
        //isEditing = false
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
        //canvasActivityView.setAnchor(top: view.topAnchor, leading: view.leadingAnchor, bottom: view.bottomAnchor, trailing: view.trailingAnchor, paddingTop:100, paddingLeft: 40, paddingBottom: 100, paddingRight: 40)
        canvasActivityView.pinToEdges(view: view, safe: true)
        
        //canvasActivityView.backAction = handleBack
        canvasActivityView.saveCanvasAction = handleSaveCanvas
        canvasActivityView.libraryAction = handleLibrary
        
        if let canvas = canvas {
            canvasActivityView.setCanvas(canvas: canvas)
        }
    }
    

    
//    fileprivate func handleBack() {
//        dismiss(animated: true, completion: nil)
//    }
    
    fileprivate func handleSaveCanvas() {
        canvasActivityView.saveCanvas()
        dismiss(animated: true, completion: nil)
    }
    
    fileprivate func handleLibrary() {
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
