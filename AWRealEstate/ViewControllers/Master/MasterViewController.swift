//
//  MasterViewController.swift
//  FinalFourLab
//
//  Created by aarthur on 7/27/21.
//

import UIKit

/// Contains a grid of all products.
class MasterViewController: UIViewController, UICollectionViewDelegate {
    lazy var tableView: UITableView = {
        UITableView()
    }()
    var viewModel = MasterViewModel()
    let isCompact: Bool

    init(isCompact: Bool) {
        self.isCompact = isCompact
        super.init(nibName: .none, bundle: .none)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    /// Setup the view.
    private func configureView() {
        view.addSubview(tableView)
        tableView.pin(to: view)
        tableView.dataSource = viewModel
        registerAssets()
    }

    /// Register table view cell class data source to create those cells, and kick off the load.
    private func registerAssets() {
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: MasterViewModel.reuseIdentifier)
    }

    /// Parse product data located in the app bundle.  These are mapped to an array of Product and displayed in the collection view.
    private func loadData() {
        viewModel.fetchFilmResource { [weak self] error in
            guard let error = error else {
                self?.tableView.reloadData()
                self?.title = self?.viewModel.film?.title
                return
            }
            let alert = UIAlertController()
            alert.title = "Try Later".localized
            alert.message = error.localizedDescription
            let okAction = UIAlertAction(title: "OK".localized, style: .default)
            alert.addAction(okAction)
            self?.present(alert, animated: true)
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        loadData()
        configureView()
    }
}
