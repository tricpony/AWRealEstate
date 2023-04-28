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

    /// Convenience to init stack with axis.
    /// - Parameters:
    ///   - axis: Desired axis, defaults to horizontal.
    /// - Returns: Instance of stack view.
    static func stack(axis: NSLayoutConstraint.Axis = .horizontal) -> UIStackView {
        let stack = UIStackView()
        stack.axis = axis
        return stack
    }
    
    /// Add single item to arranged views.
    /// - Parameters:
    ///   - stackable: Web address of service.
    func add(_ stackable: Stackable) {
        stackable.configure(stack: self)
    }

    /// Add array of items to arranged views.
    /// - Parameters:
    ///   - stackable: Web address of service.
    func add(_ stackables: [Stackable]) {
        stackables.forEach { $0.configure(stack: self) }
    }
    
    /// Remove items from arranged views.
    /// - Parameters:
    ///   - views: Remove these.
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
    /// Add float as spacing.
    /// - Parameters:
    ///   - stack: Stack to apply *self* as space.
    func configure(stack: UIStackView) {
        stack.spacing = self
    }
}

