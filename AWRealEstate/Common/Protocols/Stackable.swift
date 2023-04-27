//
//  Stackable.swift
//  FinalFourLab
//
//  Created by aarthur on 7/27/21.
//

import UIKit

/// Protocol that supports a nested stack view architecture in a purely programmatic UI.
protocol Stackable {
    func configure(stack: UIStackView)
}

extension UIStackView {

    static func stack(axis: NSLayoutConstraint.Axis = .horizontal) -> UIStackView {
        let stack = UIStackView()
        stack.axis = axis
        return stack
    }
    
    func add(_ stackable: Stackable) {
        stackable.configure(stack: self)
    }

    func add(_ stackables: [Stackable]) {
        stackables.forEach { $0.configure(stack: self) }
    }
    
    func remove(arrangedSubviews views: [UIView]) {
        views.forEach { removeArrangedSubview($0) }
    }
}

extension UIView: Stackable {
    
    /// Make a thin line.
    static func hairline() -> UIView {
        let line = UIView()
        line.backgroundColor = UIColor(named: "hairline")
        let height = line.heightAnchor.constraint(equalToConstant: 0.5)
        line.addConstraint(height)
        return line
    }

    func configure(stack: UIStackView) {
        stack.addArrangedSubview(self)
    }
    
}

extension CGFloat: Stackable {
    func configure(stack: UIStackView) {
        stack.spacing = self
    }
}

