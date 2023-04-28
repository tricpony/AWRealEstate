//
//  MasterViewModel.swift
//  AWRealEstate
//
//  Created by aarthur on 4/26/23.
//

import UIKit

typealias FetchHandler = (ServiceError?) -> Void
class MasterViewModel: NSObject {
    static let reuseIdentifier = "Cell"
    var film: Film?
    let isCompact: Bool
    let searchHandler: () -> Void
    let service = ServiceManager(session: .shared)
    var searchTerm: String = .zero {
        didSet {
            guard !searchTerm.isEmpty else {
                filteredCast = originalCast
                searchHandler()
                return
            }
            filteredCast = originalCast.filter { $0.name.contains(searchTerm) }
            searchHandler()
        }
    }
    var originalCast: [Actor] {
        film?.orderedCast ?? []
    }
    var filteredCast = [Actor]()
    
    init(searchHandler: @escaping () -> Void, isCompact: Bool) {
        self.searchHandler = searchHandler
        self.isCompact = isCompact
    }

    func fetchFilmResource(handler: @escaping FetchHandler) {
        service.startService(at: API.serviceAddress) { [weak self] result in
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
