//
//  PhotoMetadataController.swift
//  egoPics
//
//  Created by Ryan Morrison on 11/02/2018.
//  Copyright © 2018 Treehouse. All rights reserved.
//

import UIKit

class PhotoMetadataController: UITableViewController {
    
    @IBOutlet weak var photoImageView: UIImageView!
    @IBOutlet weak var captionTextField: UITextField!
    @IBOutlet weak var tagsTextField: UITextField!
    
    var displayPhoto: UIImage?
    var photo: UIImage?
    var filter: CIFilter?
    var tags = [String]()
    let queue = OperationQueue()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupNavigation()
        photoImageView.image = displayPhoto
        
        if let tagsText = tagsTextField.text {
            self.tags = tags(from: tagsText)
        }
        
        applyFilter(scaleFactor: 0.25)
    }
    
    func applyFilter(scaleFactor scale: CGFloat) {
        guard let image = photo, let selectedFilter = filter else { return }
        let imageWidth = image.size.width
        let imageHeight = image.size.height
        let size = CGSize(width: imageWidth * scale, height: imageHeight * scale)
        guard let resizedImage = image.resized(to: size) else { return }
        
        let filtrationImage = FiltrationImage(image: resizedImage)
        let operation = ImageFiltrationOperation(image: filtrationImage, filter: selectedFilter)
        operation.completionBlock = {
            if operation.isCancelled { return }
            self.photo = operation.filtrationImage.image
        }
        queue.addOperation(operation)
    }
    
    func setupNavigation() {
        let saveButton = UIBarButtonItem(barButtonSystemItem: .save, target: self, action: #selector(PhotoMetadataController.savePhoto))
        navigationItem.rightBarButtonItem = saveButton
    }
    
    @objc func savePhoto() {
        
    }
}

extension PhotoMetadataController {
    func tags(from text: String) -> [String] {
        let commaSeperatedStrings = text.split(separator: ",").map(String.init)
        let lowercaseTags = commaSeperatedStrings.map { $0.lowercased() }
        return lowercaseTags.map { $0.trimmingCharacters(in: .whitespacesAndNewlines) }
    }
}
















