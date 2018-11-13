//
//  UIImageView+.swift
//  MovieSearcher
//
//  Created by Mikhail Pchelnikov on 12/08/2018.
//  Copyright © 2018 Michael Pchelnikov. All rights reserved.
//

import UIKit

extension UIImageView {

    /**
     Convinience method for initialization with specified content mode.

     - parameter image: The inititial image.
     - parameter mode: Options to specify how a view adjusts its content when its size changes.

     - returns: An initialized image view object.
    */
    convenience init(_ image: UIImage? = nil, contentMode: UIView.ContentMode) {
        self.init(image: image)
        self.contentMode = contentMode
    }
}
