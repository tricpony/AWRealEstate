//
//  PlaceholderViewController.swift
//  FinalFourLab
//
//  Created by aarthur on 7/29/21.
//

import UIKit

/// Empty secondary view for iPad when app first launches.
class PlaceholderViewController: UIViewController {
    var placeHolderLabel = UILabel()

    override func viewDidLoad() {
        super.viewDidLoad()
        configureView()
        placeHolderLabel.text = "Empty Selection"
        
    }
    
    /// Setup the view.
    private func configureView() {
        placeHolderLabel.font = UIFont.systemFont(ofSize: 24, weight: .bold)
        let mainStackView = UIStackView.stack()
        let verticalStack = UIStackView.stack(axis: .vertical)
        verticalStack.alignment = .center
        mainStackView.alignment = .center
        mainStackView.distribution = .fill
        mainStackView.translatesAutoresizingMaskIntoConstraints = false
        verticalStack.add(placeHolderLabel)
        mainStackView.add(verticalStack)
        view.addSubview(mainStackView)
        mainStackView.pin(to: view)
    }
}
