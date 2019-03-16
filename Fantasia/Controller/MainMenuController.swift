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
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(true, animated: false)
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        navigationController?.setNavigationBarHidden(false, animated: false)
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
        navigationController?.pushViewController(canvasController, animated: true)
        //present(canvasController, animated: true, completion: nil)
    }
    
    fileprivate func handleGallery() {
        let galleryController = GalleryController()
        present(galleryController, animated: true, completion: nil)
    }
}

