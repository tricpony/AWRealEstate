//
//  DetailViewController.swift
//  AWRealEstate
//
//  Created by aarthur on 4/27/23.
//

import UIKit

class DetailViewController: UIViewController {
    @IBOutlet var nameLabel: UILabel!
    @IBOutlet var roleLabel: UILabel!
    @IBOutlet var imageView: UIImageView!
    @IBOutlet weak var nameBanner: UIView!
    @IBOutlet weak var roleBanner: UIView!
    @IBOutlet weak var nameLabelXCenter: NSLayoutConstraint!
    @IBOutlet weak var nameLabelLeading: NSLayoutConstraint!
    @IBOutlet weak var imageTrailing: NSLayoutConstraint!
    @IBOutlet weak var imageXCenter: NSLayoutConstraint!
    @IBOutlet weak var roleLabelTrailing: NSLayoutConstraint!
    var actor: Actor?
    let service = ServiceManager(session: .shared)

    override func viewDidLoad() {
        super.viewDidLoad()
        configureView()
        nameLabel.text = actor?.name
        roleLabel.text = actor?.role
        guard let imageURL = actor?.imageURL else { return }
        service.startService(at: imageURL) { [weak self] result in
            switch result {
            case .success(let data):
                self?.imageView.image = UIImage(data: data)
            default:
                return
            }
        }
    }
    
    /// Setup the view.
    private func configureView() {
        var layer = nameBanner.layer
        layer.borderColor = UIColor(named: "RoleBannerBorder")?.cgColor
        layer.borderWidth = 0.5
        layer.cornerRadius = 6.25
        layer = roleBanner.layer
        layer.borderColor = UIColor(named: "RoleBannerBorder")?.cgColor
        layer.borderWidth = 0.5
        layer.cornerRadius = 6.25
    }
    
    private func flipPriority(up: [NSLayoutConstraint], down: [NSLayoutConstraint]) {
        up.forEach { $0.priority = .defaultHigh }
        down.forEach { $0.priority = .defaultLow }
    }

    override func willTransition(to newCollection: UITraitCollection, with coordinator: UIViewControllerTransitionCoordinator) {
        let gap = 7.0
        if UIDevice.current.orientation.isLandscape {
            flipPriority(up: [imageTrailing, nameLabelLeading], down: [imageXCenter, nameLabelXCenter])
            roleBanner.backgroundColor = UIColor(named: "RoleBannerBackground-LS")
            roleLabelTrailing.constant += imageView.frame.width + gap
            view.bringSubviewToFront(imageView)
            view.sendSubviewToBack(roleBanner)
        } else {
            flipPriority(up: [imageXCenter, nameLabelXCenter], down: [imageTrailing, nameLabelLeading])
            roleBanner.backgroundColor = UIColor(named: "RoleBannerBackground")
            roleLabelTrailing.constant -= imageView.frame.width + gap
        }
    }
}
