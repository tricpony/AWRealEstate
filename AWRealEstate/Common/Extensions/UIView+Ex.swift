//
//  UIView+Ex.swift
//  ClinicalTrials
//
//  Created by aarthur on 10/26/22.
//  Copyright © 2022 Gigabit LLC. All rights reserved.
//

import Foundation
import UIKit

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
}
