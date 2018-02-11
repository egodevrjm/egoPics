//
//  PhotoPickerManager.swift
//  egoPics
//
//  Created by Ryan Morrison on 10/02/2018.
//  Copyright © 2018 Treehouse. All rights reserved.
//

import Foundation
import UIKit
import MobileCoreServices

protocol PhotoPickerManagerDelegate: class {
    func manageer(_ manager: PhotoPickerManager, didPickImage image: UIImage)
}

class PhotoPickerManager: NSObject {
    private let imagePickerController = UIImagePickerController()
    private let presentingController: UIViewController
    weak var delegate: PhotoPickerManagerDelegate?
    
    init(presentingViewController: UIViewController) {
        self.presentingController = presentingViewController
        super.init()
        
        configure()
    }
    
    func presentPhotoPicker(animated: Bool) {
        presentingController.present(imagePickerController, animated: animated, completion: nil)
    }
    
    func dismissPhotoPicker(animated: Bool, completion: (() -> Void)?) {
        imagePickerController.dismiss(animated: animated, completion: completion)
    }
    
    private func configure() {
        if UIImagePickerController.isSourceTypeAvailable(.camera) {
            imagePickerController.sourceType = .photoLibrary
            imagePickerController.navigationBar.tintColor = UIColor.cloudBurst
            
//            imagePickerController.sourceType = .camera
//            imagePickerController.cameraDevice = .front
//            imagePickerController.allowsEditing = false
//            imagePickerController.cameraCaptureMode = .photo
        } else {
            imagePickerController.sourceType = .photoLibrary
        }
        
        imagePickerController.mediaTypes = [kUTTypeImage as String]
        imagePickerController.delegate = self
    }
    
}

extension PhotoPickerManager: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        guard let image = info[UIImagePickerControllerOriginalImage] as? UIImage else { return }
        delegate?.manageer(self, didPickImage: image)
    }
}








































