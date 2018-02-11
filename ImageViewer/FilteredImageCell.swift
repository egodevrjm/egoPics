//
//  FilteredImageCell.swift
//  egoPics
//
//  Created by Ryan Morrison on 11/02/2018.
//  Copyright © 2018 Treehouse. All rights reserved.
//

import UIKit
import GLKit

class FilteredImageCell: UICollectionViewCell {
    static let reuseIdentifier = String(describing: FilteredImageCell.self)
    
    var eaglContext: EAGLContext!
    var image: CIImage!
    
    private lazy var glkView: GLKView = {
        let view = GLKView(frame: self.contentView.frame, context: self.eaglContext)
        view.translatesAutoresizingMaskIntoConstraints = false
        view.delegate = self
        return view
    }()
    
    private lazy var context: CIContext = {
        return CIContext(eaglContext: self.eaglContext)
    }()
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        contentView.addSubview(glkView)
        NSLayoutConstraint.activate([
            glkView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            glkView.topAnchor.constraint(equalTo: contentView.topAnchor),
            glkView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            glkView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
            ])
    }
}

extension FilteredImageCell: GLKViewDelegate {
    func glkView(_ view: GLKView, drawIn rect: CGRect) {
        let drawableRectSize = CGSize(width: view.drawableWidth, height: view.drawableHeight)
        let drawableRect = CGRect(origin: .zero, size: drawableRectSize)
        
        context.draw(image, in: drawableRect, from: image.extent)
    }
}


















