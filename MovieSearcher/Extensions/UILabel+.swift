//
//  UILabel+.swift
//  MovieSearcher
//
//  Created by Mikhail Pchelnikov on 05/08/2018.
//  Copyright © 2018 Michael Pchelnikov. All rights reserved.
//

import UIKit

extension UILabel {

    /**
     Convenient factory method for UILabel declaration.

     - parameter font: Font of UILabel.
     - parameter color: Color of UILabel.
     - parameter lines: Number of lines.
     - parameter alignment: Text alignment.

     - returns: An initialized label object.
     */
    convenience init(font: UIFont, color: UIColor = .black, lines: Int = 0, alignment: NSTextAlignment = .left) {
        self.init()

        self.font          = font
        self.textColor     = color
        self.numberOfLines = lines
        self.textAlignment = alignment
    }
}
