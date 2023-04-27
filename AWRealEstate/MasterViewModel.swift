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
    let service = ServiceManager(session: .shared)
    
    init(isCompact: Bool) {
        self.isCompact = isCompact
    }

    func fetchFilmResource(handler: @escaping FetchHandler) {
        service.startService(at: API.serviceAddress) { [weak self] result in
            switch result {
            case .success(let data):
                let decoder = JSONDecoder()
                let resource = try? decoder.decode(Film.self, from: data)
                self?.film = resource
                handler(nil)
            case .failure(let error):
                handler(error)
            }
        }
    }
}

extension MasterViewModel: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        film?.cast.count ?? 0
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: Self.reuseIdentifier, for: indexPath)
        let actor = film?.orderedCast[indexPath.row]
        cell.textLabel?.text = actor?.name
        cell.textLabel?.adjustsFontForContentSizeCategory = true
        return cell
    }
}
