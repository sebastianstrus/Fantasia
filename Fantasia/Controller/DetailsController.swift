//
//  DetailsController.swift
//  Fantasia
//
//  Created by Sebastian Strus on 2019-02-10.
//  Copyright © 2019 Sebastian Strus. All rights reserved.
//

import UIKit

class DetailsController: UIViewController {
    
    fileprivate var detailsView: DetailsView!
    
    fileprivate var canvas: CanvasObject?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupLayout()
    }
    
    // MARK: - Private functions
    fileprivate func setupLayout() {
        detailsView = DetailsView(frame: view.frame)
        view.addSubview(detailsView)
        
        detailsView.backAction = handleBack
        detailsView.editAction = handleEdit
        
        detailsView.setCanvas(canvas: canvas!)
    }
    
    fileprivate func handleBack() {
        dismiss(animated: true, completion: nil)
    }
    
    fileprivate func handleEdit() {
        print("Edit soon")
    }
    
    // MARK: - Public functions
    func setCanvas(canvas: CanvasObject) {
        self.canvas = canvas
    }
}

