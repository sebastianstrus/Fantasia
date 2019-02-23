//
//  MainMenuController.swift
//  Fantasia
//
//  Created by Sebastian Strus on 2019-02-01.
//  Copyright © 2019 Sebastian Strus. All rights reserved.
//

import UIKit

class MainMenuController: UIViewController {
    
    
    fileprivate var mainMenuView: MainMenuView!

    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
    }
    
    // MARK: - Private functions
    fileprivate func setupView() {
        self.mainMenuView = MainMenuView()
        self.mainMenuView.newCanvasAction = handleNewCanvas
        self.mainMenuView.galleryAction = handleGallery
        self.view.addSubview(mainMenuView)
        mainMenuView.pinToEdges(view: view, safe: false)
    }
    
    fileprivate func handleNewCanvas() {
        let canvasController = CanvasController()
        present(canvasController, animated: true, completion: nil)
    }
    
    fileprivate func handleGallery() {
        let galleryController = GalleryController()
        present(galleryController, animated: true, completion: nil)
    }
}

