//
//  MarkerKit.swift
//
//  MIT License
//
//  Copyright (c) 2017 Michael Pchelnikov
//
//  Permission is hereby granted, free of charge, to any person obtaining a copy
//  of this software and associated documentation files (the "Software"), to deal
//  in the Software without restriction, including without limitation the rights
//  to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
//  copies of the Software, and to permit persons to whom the Software is
//  furnished to do so, subject to the following conditions:
//
//  The above copyright notice and this permission notice shall be included in all
//  copies or substantial portions of the Software.
//
//  THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
//  IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
//  FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
//  AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
//  LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
//  OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
//  SOFTWARE.

import Foundation
import UIKit

public typealias MarkerView = UIView

public extension MarkerView {
    public var mrk: MarkerConstraintView {
        return MarkerConstraintView(view: self)
    }
}

public struct MarkerConstraintView {
    
    //MARK: public
    
    //MARK: filling
    @discardableResult
    public func fillSuperview(_ edges: UIEdgeInsets = UIEdgeInsets.zero) -> [NSLayoutConstraint] {
        var constraints: [NSLayoutConstraint] = []
        
        if let superview = self.view.superview {
            let topConstraint = top(to: superview, constant: edges.top)
            let leadingConstraint = leading(to: superview, constant: edges.left)
            let bottomConstraint = bottom(to: superview, constant: -edges.bottom)
            let trailingConstraint = trailing(to: superview, constant: -edges.right)
            
            constraints = [topConstraint, leadingConstraint, bottomConstraint, trailingConstraint]
        }
        
        return constraints
    }
    
    //MARK: sides
    @discardableResult
    public func leading(to view: Any?, attribute: NSLayoutAttribute = .leading, relation: NSLayoutRelation = .equal, constant: CGFloat = 0.0) -> NSLayoutConstraint {
        let constraint = makeConstraint(attribute: .leading, toView: view, attribute: attribute, relation: relation, constant: constant)
        addConstraintToSuperview(constraint)
        return constraint
    }

    @discardableResult
    public func trailing(to view: Any?, attribute: NSLayoutAttribute = .trailing, relation: NSLayoutRelation = .equal, constant: CGFloat = 0.0) -> NSLayoutConstraint {
        let constraint = makeConstraint(attribute: .trailing, toView: view, attribute: attribute, relation: relation, constant: constant)
        addConstraintToSuperview(constraint)
        return constraint
    }
    
    @discardableResult
    public func left(to view: Any?, attribute: NSLayoutAttribute = .left, relation: NSLayoutRelation = .equal, constant: CGFloat = 0.0) -> NSLayoutConstraint {
        let constraint = makeConstraint(attribute: .left, toView: view, attribute: attribute, relation: relation, constant: constant)
        addConstraintToSuperview(constraint)
        return constraint
    }
    
    @discardableResult
    public func right(to view: Any?, attribute: NSLayoutAttribute = .right, relation: NSLayoutRelation = .equal, constant: CGFloat = 0.0) -> NSLayoutConstraint {
        let constraint = makeConstraint(attribute: .right, toView: view, attribute: attribute, relation: relation, constant: constant)
        addConstraintToSuperview(constraint)
        return constraint
    }

    @discardableResult
    public func top(to view: Any?, attribute: NSLayoutAttribute = .top, relation: NSLayoutRelation = .equal, constant: CGFloat = 0.0) -> NSLayoutConstraint {
        let constraint = makeConstraint(attribute: .top, toView: view, attribute: attribute, relation: relation, constant: constant)
        addConstraintToSuperview(constraint)
        return constraint
    }
    
    @discardableResult
    public func bottom(to view: Any?, attribute: NSLayoutAttribute = .bottom, relation: NSLayoutRelation = .equal, constant: CGFloat = 0.0) -> NSLayoutConstraint {
        let constraint = makeConstraint(attribute: .bottom, toView: view, attribute: attribute, relation: relation, constant: constant)
        addConstraintToSuperview(constraint)
        return constraint
    }
    
    //MARK: centering
    @discardableResult
    public func centerX(to view: Any?, relation: NSLayoutRelation = .equal, constant: CGFloat = 0.0) -> NSLayoutConstraint {
        let constraint = makeConstraint(attribute: .centerX, toView: view, attribute: .centerX, relation: relation, constant: constant)
        addConstraintToSuperview(constraint)
        return constraint
    }

    @discardableResult
    public func centerY(to view: Any?, relation: NSLayoutRelation = .equal, constant: CGFloat = 0.0) -> NSLayoutConstraint {
        let constraint = makeConstraint(attribute: .centerY, toView: view, attribute: .centerY, relation: relation, constant: constant)
        addConstraintToSuperview(constraint)
        return constraint
    }
    
    @discardableResult
    public func center(to view: Any?) -> [NSLayoutConstraint] {
        let centerXConstraint = centerX(to: view)
        let centerYConstraint = centerY(to: view)
        let constraints = [centerXConstraint, centerYConstraint]

        return constraints
    }

    //MARK: measurement
    @discardableResult
    public func width(to view: Any?, relation: NSLayoutRelation = .equal, constant: CGFloat) -> NSLayoutConstraint {
        let constraint = makeConstraint(attribute: .width, toView: view, attribute: .width, relation: relation, constant: constant)
        addConstraintToSuperview(constraint)
        return constraint
    }
    
    @discardableResult
    public func width(_ constant: CGFloat) -> NSLayoutConstraint {
        let constraint = makeConstraint(attribute: .width, toView: nil, attribute: .width, relation: .equal, constant: constant)
        addConstraintToSuperview(constraint)
        return constraint
    }

    @discardableResult
    public func height(to view: Any?, relation: NSLayoutRelation = .equal, constant: CGFloat) -> NSLayoutConstraint {
        let constraint = makeConstraint(attribute: .height, toView: view, attribute: .height, relation: relation, constant: constant)
        addConstraintToSuperview(constraint)
        return constraint
    }
    
    @discardableResult
    public func height(_ constant: CGFloat) -> NSLayoutConstraint {
        let constraint = makeConstraint(attribute: .height, toView: nil, attribute: .height, relation: .equal, constant: constant)
        addConstraintToSuperview(constraint)
        return constraint
    }
    
    
    //MARK: private
    fileprivate func addConstraintToSuperview(_ constraint: NSLayoutConstraint) {
        self.view.translatesAutoresizingMaskIntoConstraints = false
        self.view.superview?.addConstraint(constraint)
    }
    
    fileprivate func makeConstraint(attribute attr1: NSLayoutAttribute, toView: Any?, attribute attr2: NSLayoutAttribute, relation: NSLayoutRelation, constant: CGFloat) -> NSLayoutConstraint {
        
        let constraint = NSLayoutConstraint(
            item: self.view,
            attribute: attr1,
            relatedBy: relation,
            toItem: toView,
            attribute: attr2,
            multiplier: 1.0,
            constant: constant)
        
        return constraint
    }
    
    internal let view: MarkerView
    
    internal init(view: MarkerView) {
        self.view = view
    }
}
