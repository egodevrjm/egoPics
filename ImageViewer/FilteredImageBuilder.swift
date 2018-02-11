//
//  FilteredImageBuilder.swift
//  egoPics
//
//  Created by Ryan Morrison on 11/02/2018.
//  Copyright © 2018 Treehouse. All rights reserved.
//

import UIKit
import CoreImage

class FilteredImageBuilder {
    private let image: UIImage
    
    init(image: UIImage) {
        self.image = image
    }
    
    func applyFilter(_ filter: CIFilter) -> CIImage? {
        guard let inputImage = image.ciImage ?? CIImage(image: self.image) else { return nil }
        
        filter.setValue(inputImage, forKey: kCIInputImageKey)
        guard let outputImage = filter.outputImage else { return nil }
        
        return outputImage.cropped(to: inputImage.extent)
    }
    
    func image(withFilters filters: [CIFilter]) -> [CIImage] {
        return filters.flatMap { applyFilter($0) }
    }
    
    func imageWithDefaultFilters() -> [CIImage] {
        return image(withFilters: PhotoFilter.defaultFilters)
    }
    
}






























