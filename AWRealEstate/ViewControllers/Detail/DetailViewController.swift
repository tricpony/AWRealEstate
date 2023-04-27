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
    @IBOutlet weak var stackView: UIStackView!
    @IBOutlet weak var nameBanner: UIView!
    @IBOutlet weak var roleBanner: UIView!
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
    override func willTransition(to newCollection: UITraitCollection, with coordinator: UIViewControllerTransitionCoordinator) {
        if UIDevice.current.orientation.isLandscape {
            let vstack = UIStackView.stack(axis: .vertical)
            vstack.add([nameLabel, roleBanner])
            let hstack = UIStackView(arrangedSubviews: [vstack, imageView])
            stackView.remove(arrangedSubviews: stackView.arrangedSubviews)
            stackView.add(hstack)
        } else {
            let vstack = UIStackView.stack(axis: .vertical)
            vstack.distribution = .equalSpacing
            vstack.add([nameLabel, imageView, roleLabel])
            stackView.remove(arrangedSubviews: stackView.arrangedSubviews)
            stackView.add(vstack)
        }
    }
}
