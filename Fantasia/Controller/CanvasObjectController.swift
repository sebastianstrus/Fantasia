//
//  ModelController.swift
//  Fantasia
//
//  Created by Sebastian Strus on 2019-02-10.
//  Copyright © 2019 Sebastian Strus. All rights reserved.
//

import Foundation
import CoreData
import UIKit


class CanvasObjectController {
    
    static let shared = CanvasObjectController()
    
    let entityName = "CanvasObject"
    
    private var savedCanvasObjects = [NSManagedObject]()
    private var images = [UIImage]()
    private var managedContext: NSManagedObjectContext!
    var canvases: [CanvasObject] = []
    
    private init() {
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else { return }
        managedContext = appDelegate.persistentContainer.viewContext
        
        fetchCanvasObjects()
    }
    
    func fetchCanvasObjects() {
        let canvasObjectRequest = NSFetchRequest<NSManagedObject>(entityName: entityName)
        
        do {
            savedCanvasObjects = try managedContext.fetch(canvasObjectRequest)
            
            canvases.removeAll()
            images.removeAll()
            
            for canvasObject in savedCanvasObjects {
                let savedCanvasObject = canvasObject as! CanvasObject
                
                guard savedCanvasObject.imageName != nil else { return }
                guard savedCanvasObject.title != nil else { return }
                guard savedCanvasObject.date != nil else { return }
                canvases.append(savedCanvasObject)
                
            }
        } catch let error as NSError {
            print("Could not return image objects: \(error)")
        }
    }
    
    func saveCanvasObject(image: UIImage, title: String, date: Date) {
        let imageName = ImageController.shared.saveImage(image: image)
        
        if let imageName = imageName {
            let coreDataEntity = NSEntityDescription.entity(forEntityName: entityName, in: managedContext)
            let newCanvasObjectEntity = NSManagedObject(entity: coreDataEntity!, insertInto: managedContext) as! CanvasObject
            
            newCanvasObjectEntity.imageName = imageName
            newCanvasObjectEntity.date = date
            newCanvasObjectEntity.title = title
            
            do {
                try managedContext.save()
                
                images.append(image)
                
                print("\(imageName) was saved in new object.")
            } catch let error as NSError {
                print("Could not save new image object: \(error)")
            }
        }
    }
    
    func deleteCanvasObject(imageIndex: Int) {
        guard images.indices.contains(imageIndex) && savedCanvasObjects.indices.contains(imageIndex) else { return }
        
        let imageObjectToDelete = savedCanvasObjects[imageIndex] as! CanvasObject
        let imageName = imageObjectToDelete.imageName
        
        do {
            managedContext.delete(imageObjectToDelete)
            
            try managedContext.save()
            
            if let imageName = imageName {
                ImageController.shared.deleteImage(imageName: imageName)
            }
            
            savedCanvasObjects.remove(at: imageIndex)
            images.remove(at: imageIndex)
            
            print("CanvasObject object was deleted.")
        } catch let error as NSError {
            print("Could not delete CanvasObject: \(error)")
        }
    }
}
