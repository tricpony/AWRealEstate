//
//  MasterViewModel.swift
//  AWRealEstate
//
//  Created by aarthur on 4/26/23.
//

import UIKit

typealias FetchHandler = (ServiceError?) -> Void
typealias FilterHandler = () -> Void
class MasterViewModel: NSObject {
    static let reuseIdentifier = "Cell"
    var film: Film?
    let filterHandler: () -> Void
    let serviceAddress: URL
    let service = ServiceManager(session: .shared)
    var searchTerm: String = .zero {
        didSet {
            guard !searchTerm.isEmpty else {
                filteredCast = originalCast
                filterHandler()
                return
            }
            filteredCast = originalCast.filter { $0.name.contains(searchTerm) }
            filterHandler()
        }
    }
    var originalCast: [Actor] {
        film?.orderedCast ?? []
    }
    var filteredCast = [Actor]()
    
    init(filterHandler: @escaping FilterHandler, serviceAddress: URL = API.serviceAddress) {
        self.filterHandler = filterHandler
        self.serviceAddress = serviceAddress
    }

    /// Perform service call and send results to *handler*.
    /// - Parameters:
    ///   - handler: Closure to pass results.
    func fetchFilmResource(handler: @escaping FetchHandler) {
        service.startService(at: serviceAddress) { [weak self] result in
            switch result {
            case .success(let data):
                let decoder = JSONDecoder()
                let resource = try? decoder.decode(Film.self, from: data)
                self?.film = resource
                self?.filteredCast = self?.originalCast ?? []
                handler(nil)
            case .failure(let error):
                handler(error)
            }
        }
    }
}

extension MasterViewModel: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        filteredCast.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: Self.reuseIdentifier, for: indexPath)
        let actor = filteredCast[indexPath.row]
        cell.textLabel?.attributedText = actor.name.hightlightAttributedString(of: searchTerm,
                                                                               backgroundColor: UIColor(named: "FilterBgHighlight"),
                                                                               foregroundColor: UIColor(named: "FilterFgHighlight"))
        cell.textLabel?.highlightedTextColor = .white
        cell.textLabel?.adjustsFontForContentSizeCategory = true
        return cell
    }
}

extension MasterViewModel: UISearchResultsUpdating {
    func updateSearchResults(for searchController: UISearchController) {
        guard let text = searchController.searchBar.text else { return }
        searchTerm = text
    }
}
