//
//  UIImageView+.swift
//  TheMovies
//
//  Created by Mikhail Pchelnikov on 12/08/2018.
//  Copyright © 2018 Michael Pchelnikov. All rights reserved.
//

import UIKit

extension UIImageView {
    
    /// Convinience method for initialization with specified content mode.
    ///
    /// - Parameters:
    ///   - image: The inititial image.
    ///   - contentMode: Options to specify how a view adjusts its content when its size changes.
    convenience init(_ image: UIImage? = nil, contentMode: UIView.ContentMode) {
        self.init(image: image)
        self.contentMode = contentMode
    }
}
