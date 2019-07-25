//
//  UILabel+.swift
//  TheMovies
//
//  Created by Mikhail Pchelnikov on 05/08/2018.
//  Copyright © 2018 Michael Pchelnikov. All rights reserved.
//

import UIKit

extension UILabel {

    /// Convenient factory method for UILabel declaration.
    ///
    /// - Parameters:
    ///   - font: Font of the label.
    ///   - color: Text color of the label.
    ///   - backgroundColor: Background color of the label.
    ///   - lines: Number of lines.
    ///   - alignment: Text alignment.
    convenience init(font: UIFont,
                     color: UIColor = .black,
                     backgroundColor: UIColor = .clear,
                     lines: Int = 0,
                     alignment: NSTextAlignment = .left) {
        self.init()

        self.font            = font
        self.textColor       = color
        self.backgroundColor = backgroundColor
        self.numberOfLines   = lines
        self.textAlignment   = alignment
    }
}
