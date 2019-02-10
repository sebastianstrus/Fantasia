//
//  DetailsController.swift
//  Fantasia
//
//  Created by Sebastian Strus on 2019-02-10.
//  Copyright © 2019 Sebastian Strus. All rights reserved.
//

import UIKit

class DetailsController: UIViewController {
    
    var detailsView: DetailsView!
    
    var canvas: CanvasObject?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupLayout()
    }
    
    fileprivate func setupLayout() {
        print("test")
        detailsView = DetailsView(frame: view.frame)
        view.addSubview(detailsView)
        detailsView.backAction = handleBack
        detailsView.pinToEdges(view: view)
        
        let image = ImageController.shared.fetchImage(imageName: (canvas?.imageName)!)
        detailsView.imageView.image = ImageController.shared.fetchImage(imageName: (canvas?.imageName)!)
        detailsView.titleLabel.text = canvas?.title
        detailsView.dateLabel.text = canvas?.date?.formatedString()
        
        let height_by_width = image!.size.height / image!.size.width
        detailsView.setImageHeight(image_height_by_width: Int(height_by_width))
    }
    
    fileprivate func handleBack() {
        dismiss(animated: true, completion: nil)
    }
}

