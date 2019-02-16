//
//  MyCollectionController.swift
//  Fantasia
//
//  Created by Sebastian Strus on 2019-02-03.
//  Copyright © 2019 Sebastian Strus. All rights reserved.
//
import UIKit

class MyCollectionController: UIViewController, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout, UICollectionViewDataSource {
    
    fileprivate var myCollectionView: MyCollectionView!
    fileprivate let cellId = "cellId"
    
    private var canvases: [CanvasObject]  = []
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupView()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        CanvasObjectController.shared.fetchCanvasObjects()
        canvases = CanvasObjectController.shared.canvases
        self.myCollectionView.reload()
    }
    
    
    private func setupView() {
        let myCV = MyCollectionView(frame: view.frame)
        self.myCollectionView = myCV
        
        view.addSubview(myCollectionView)
        myCollectionView.backAction = handleBack
        myCollectionView.setDelegate(d: self)
        myCollectionView.setDataSource(ds: self)
        myCollectionView.registerCell(className: MyCollectionCell.self, id: cellId)
    }
    
    func handleBack() {
        dismiss(animated: true, completion: nil)
    }
    
    // MARK: - UICollectionViewDataSource functions
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return canvases.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellId, for: indexPath) as! MyCollectionCell
        cell.canvas = canvases[indexPath.row]
        return cell
    }
    
    // MARK: - UICollectionViewDelegate functions
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let detailsController = DetailsController()
        detailsController.canvas = canvases[indexPath.row]
        present(detailsController, animated: true, completion: nil)
    }
    
    // MARK: - UICollectionViewDelegateFlowLayout functions
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let someImage: UIImage = ImageController.shared.fetchImage(imageName: (canvases[0].imageName!)) ?? UIImage(named: "blur_background")!
        let height_by_width = someImage.size.height / someImage.size.width
        
        let side = view.frame.width / 3 -  (Device.IS_IPHONE ? 12 : 24)
        return CGSize(width: side, height: side * height_by_width)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        let space: CGFloat = Device.IS_IPHONE ? 8 : 16
        return UIEdgeInsets(top: space, left: space, bottom: space, right: space)
    }
}
