//
//  MasterViewController.swift
//  AWRealEstate
//
//  Created by aarthur on 4/26/23.
//

import UIKit

/// Contains a grid of all products.
class MasterViewController: UIViewController {
    lazy var tableView: UITableView = {
        UITableView()
    }()
    lazy var viewModel: MasterViewModel = {
        MasterViewModel(isCompact: isCompact)
    }()
    let isCompact: Bool

    init(isCompact: Bool) {
        self.isCompact = isCompact
        super.init(nibName: .none, bundle: .none)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    /// Register table view cell class data source to create those cells, and kick off the load.
    private func registerAssets() {
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: MasterViewModel.reuseIdentifier)
    }

    /// Invoke service to load film cast.
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

    /// Setup the view.
    private func configureView() {
        view.addSubview(tableView)
        tableView.pin(to: view)
        tableView.dataSource = viewModel
        tableView.delegate = self
        navigationItem.backBarButtonItem = UIBarButtonItem(title: .zero, style: .plain, target: nil, action: nil)
        registerAssets()
    }
}

extension MasterViewController: UITableViewDelegate {

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if isCompact {
            tableView.deselectRow(at: indexPath, animated: false)
        }
        let actor = viewModel.film?.orderedCast[indexPath.row]
        let sb = UIStoryboard(name: "DetailViewController", bundle: .none)
        guard let detailViewController = sb.instantiateInitialViewController() as? DetailViewController else { return }
        detailViewController.actor = actor
        if isCompact {
            navigationController?.pushViewController(detailViewController, animated: true)
        } else {
            let nav = UINavigationController(rootViewController: detailViewController)
            showDetailViewController(nav, sender: .none)
        }
    }
}

