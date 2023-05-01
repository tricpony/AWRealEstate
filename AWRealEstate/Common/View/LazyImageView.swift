//
//  LazyImageView.swift
//  TeladocLab
//
//  Created by aarthur on 8/30/20.
//  Copyright © 2020 Gigabit LLC. All rights reserved.
//

import UIKit

/// An image view that will load itself from the url in a Model protocol.
class LazyImageView: UIView {
    var pinwheel = UIActivityIndicatorView()
    var imageView = UIImageView()
    let service = ServiceManager(session: .shared)

    required init?(coder: NSCoder) {
        super.init(coder: coder)
        configureView()
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configureView()
    }
    
    private func configureView() {
        // border
        layer.borderWidth = 0
        layer.cornerRadius = 5
        layer.masksToBounds = true
        
        pinwheel.style = .medium
        pinwheel.hidesWhenStopped = true
        pinwheel.translatesAutoresizingMaskIntoConstraints = false
        imageView.translatesAutoresizingMaskIntoConstraints = false
        
        addSubview(pinwheel)
        addSubview(imageView)
        imageView.pin(to: self)
        NSLayoutConstraint.activate([
            pinwheel.centerYAnchor.constraint(equalTo: centerYAnchor),
            pinwheel.centerXAnchor.constraint(equalTo: centerXAnchor)
        ])
    }
    
    /// Use this for table cells.
    func prepareForReuse() {
        imageView.image = .none
    }
    
    /// Fetch image and load into image view.
    /// - Parameters:
    ///   - model: Protocol the product conforms to.
    func performImageService<T: ImageModel>(model: T?) {
        guard let url = model?.imageURL else {
            imageView.image = UIImage(named: "Placeholder")
            return
        }
        pinwheel.startAnimating()

        service.startService(at: url) { [weak self] result in
            self?.pinwheel.stopAnimating()
            switch result {
            case .success(let data):
                self?.imageView.contentMode = self?.contentMode ?? .scaleAspectFit
                self?.imageView.image = UIImage(data: data)
            case .failure(let error):
                self?.imageView.image = UIImage(named: "Placeholder")
                debugPrint("*** Error: \(String(describing: error.errorDescription))")
            }
        }
    }
}
