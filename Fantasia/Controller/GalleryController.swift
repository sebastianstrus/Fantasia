//
//  GalleryController.swift
//  Fantasia
//
//  Created by Sebastian Strus on 2019-02-03.
//  Copyright © 2019 Sebastian Strus. All rights reserved.
//
import UIKit

class GalleryController: UIViewController, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout, UICollectionViewDataSource, UINavigationControllerDelegate, GalleryCellDelegate {
    
    fileprivate var galleryView: GalleryView!
    fileprivate let cellId = "cellId"
    
    fileprivate var canvases: [CanvasObject]  = [] {
        didSet {
            galleryView.toggleInfoLabel(isEmpty: canvases.isEmpty)
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupNavigationBar()
        setupView()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        CanvasObjectController.shared.fetchCanvasObjects()
        canvases = CanvasObjectController.shared.canvases
        self.galleryView.reload(isEmpty: canvases.isEmpty)
        
    }
    
    fileprivate func setupNavigationBar() {
        navigationItem.rightBarButtonItem = editButtonItem
        navigationItem.title = "Gallery"
        let textAttributes = [NSAttributedString.Key.foregroundColor:UIColor.white]
        navigationController?.navigationBar.titleTextAttributes = textAttributes
        
    }
    
    fileprivate func setupView() {
        galleryView = GalleryView(frame: view.frame)        
        view.addSubview(galleryView)
        galleryView.setDelegate(d: self)
        galleryView.setDataSource(ds: self)
        galleryView.registerCell(className: GalleryCell.self, id: cellId)
    }

    @objc fileprivate func handleEdit() {
        setEditing(!isEditing, animated: true)
    }
    
    // MARK: - UICollectionViewDataSource functions
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return canvases.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellId, for: indexPath) as! GalleryCell
        cell.canvas = canvases[indexPath.row]
        cell.delegate = self
        return cell
    }
    
    // MARK: - UICollectionViewDelegate functions
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        setEditing(false, animated: false)
        let detailsController = DetailsController()
        detailsController.canvas = canvases[indexPath.row]
        detailsController.canvasIndex = indexPath.row
        navigationController?.pushViewController(detailsController, animated: true)
        //present(detailsController, animated: true, completion: nil)
    }
    
    // Mark: - Delete items
    override func setEditing(_ editing: Bool, animated: Bool) {
        super.setEditing(editing, animated: animated)
        //galleryView.toggleEditButton(isEditing: editing)
        let indexPaths = galleryView.collectionView.indexPathsForVisibleItems
        for indexPath in indexPaths {
            if let cell = galleryView.collectionView.cellForItem(at: indexPath) as? GalleryCell {
                cell.isEditing = editing
            }
        }
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
    
    // MARK: - GalleryCellDelegate functions
    func delete(cell: GalleryCell) {
        if let indexPath = galleryView.collectionView.indexPath(for: cell) {
            canvases.remove(at: indexPath.row)
            galleryView.collectionView.deleteItems(at: [indexPath])
            CanvasObjectController.shared.deleteCanvasObject(imageIndex: indexPath.row)
        }
    }
}
