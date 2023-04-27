//
//  UIView+Ex.swift
//  ClinicalTrials
//
//  Created by aarthur on 10/26/22.
//  Copyright © 2022 Gigabit LLC. All rights reserved.
//

import Foundation
import UIKit

enum CenterDirection {
    case horizontal, vertical, both
}
extension UIView {
    func pin(to superView: UIView,
             left: CGFloat = .zero,
             top: CGFloat = .zero,
             right: CGFloat = .zero,
             bottom: CGFloat = .zero) {
        translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate(
            [leftAnchor.constraint(equalTo: superView.leftAnchor, constant: left),
             topAnchor.constraint(equalTo: superView.topAnchor, constant: top),
             rightAnchor.constraint(equalTo: superView.rightAnchor, constant: -right),
             bottomAnchor.constraint(equalTo: superView.bottomAnchor, constant: -bottom)
            ])
    }
    
    func pin(to superView: UIView, all gap: CGFloat = .zero) {
        pin(to: superView, left: gap, top: gap, right: gap, bottom: gap)
    }
    
    func center(to superView: UIView, direction: CenterDirection = .both) {
        switch direction {
        case .horizontal:
            NSLayoutConstraint.activate([centerXAnchor.constraint(equalTo: superView.centerXAnchor)])
        case .vertical:
            NSLayoutConstraint.activate([centerYAnchor.constraint(equalTo: superView.centerYAnchor)])
        case .both:
            NSLayoutConstraint.activate(
                [centerXAnchor.constraint(equalTo: superView.centerXAnchor),
                centerYAnchor.constraint(equalTo: superView.centerYAnchor)]
            )
        }
    }
}
