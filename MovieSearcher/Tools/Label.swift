//
//  Label.swift
//  MovieSearcher
//
//  Created by Mikhail Pchelnikov on 10/06/2018.
//  Copyright © 2018 Michael Pchelnikov. All rights reserved.
//

import UIKit

struct Label {
    
    static func custom(_ font: UIFont, color: UIColor = .black, lines: Int = 1, alignment: NSTextAlignment = .left) -> UILabel {
        let label = UILabel()
        
        label.font          = font
        label.textColor     = color
        label.numberOfLines = lines
        label.textAlignment = alignment
        
        return label
    }
}
