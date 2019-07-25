//
//  UIView+.swift
//  TheMovies
//
//  Created by Mikhail Pchelnikov on 12/08/2018.
//  Copyright © 2018 Michael Pchelnikov. All rights reserved.
//

import UIKit

extension UIView {

    /// Adds the set of subviews to current view.
    ///
    /// - Parameter subviews: The set of subviews.
    func add(subviews: UIView...) {
        subviews.forEach(addSubview)
    }
}
