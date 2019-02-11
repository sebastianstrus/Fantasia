//
//  MainMenuController.swift
//  Fantasia
//
//  Created by Sebastian Strus on 2019-02-01.
//  Copyright © 2019 Sebastian Strus. All rights reserved.
//

import UIKit

class MainMenuController: UIViewController {
    
    
    var mainMenuView: MainMenuView!

    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
    }
    
    func setupView() {
        self.mainMenuView = MainMenuView(frame: view.frame)
        self.mainMenuView.newCanvasAction = handleNewCanvas
        self.mainMenuView.myCollectionAction = handleMyCollection
        self.view.addSubview(mainMenuView)        
    }
    
    // MARK: - Events
    func handleNewCanvas() {
        let canvasController = CanvasController()
        present(canvasController, animated: true, completion: nil)
    }
    
    func handleMyCollection() {
        let myCollectionController = MyCollectionController()
        present(myCollectionController, animated: true, completion: nil)
    }
}

