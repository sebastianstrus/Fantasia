//
//  DetailsController.swift
//  Paintera
//
//  Created by Sebastian Strus on 2019-02-10.
//  Copyright © 2019 Sebastian Strus. All rights reserved.
//

import UIKit

class DetailsController: UIViewController {
    
    fileprivate var detailsView: DetailsView!
    
    public var canvas: CanvasObject?
    public var canvasIndex: Int?
    
    // MARK: - Override functions
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupNavigationBar()
        setupLayout()
    }
    
    // MARK: - Private functions
    fileprivate func setupNavigationBar() {
        //navigationItem.rightBarButtonItem = editButtonItem
        navigationItem.title = canvas?.title
        let textAttributes = [NSAttributedString.Key.foregroundColor:UIColor.white]
        navigationController?.navigationBar.titleTextAttributes = textAttributes
        
        let editButton: UIButton = {
            let button = UIButton(type: .custom)
            button.setImage(UIImage(named: "button_edit"), for: .normal)
            button.tintColor = UIColor.white
            button.addTarget(self, action: #selector(handleEdit), for: .touchUpInside)
            return button
        }()
        
        let editItem = UIBarButtonItem(customView: editButton)
        editItem.customView?.widthAnchor.constraint(equalToConstant: 44).isActive = true//ipad 50
        editItem.customView?.heightAnchor.constraint(equalToConstant: 44).isActive = true
        
        self.navigationItem.rightBarButtonItem = editItem
    }

    fileprivate func setupLayout() {
        detailsView = DetailsView(frame: view.frame)
        view.addSubview(detailsView)
        detailsView.setCanvas(canvas: canvas!)
    }
    
    fileprivate func handleBack() {
        dismiss(animated: true, completion: nil)
    }
    
    @objc fileprivate func handleEdit() {
        print("Edit soon")
        let canvasController = CanvasController()
        canvasController.canvas = canvas
        canvasController.canvasIndex = canvasIndex
        canvasController.isEditing = true
        navigationController?.pushViewController(canvasController, animated: true)
    }
    
    // MARK: - Public functions
    func setCanvas(canvas: CanvasObject) {
        self.canvas = canvas
    }
}

