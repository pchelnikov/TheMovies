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
     */
    convenience init(font: UIFont, color: UIColor = .black, lines: Int = 1, alignment: NSTextAlignment = .left) {
        self.init()

        self.font          = font
        self.textColor     = color
        self.numberOfLines = lines
        self.textAlignment = alignment
    }
}
