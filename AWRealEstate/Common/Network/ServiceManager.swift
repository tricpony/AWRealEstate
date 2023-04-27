//
//  ServiceManager.swift
//  ClinincalTrials
//
//  Created by aarthur on 8/28/20.
//  Copyright © 2020 Gigabit LLC. All rights reserved.
//

import Foundation
import Combine

typealias ServiceResult = Result<Data, ServiceError>
struct ServiceError: Error, LocalizedError {
    var errorDescription: String?
    init(errorDescription: String?) {
        self.errorDescription = errorDescription
    }
}

/// Class  for sending service requests.
class ServiceManager {
    var inFlight = false
    var timeOut: TimeInterval = 15
    private let session: URLSession
    private var subscribers = Set<AnyCancellable>()

    init(session: URLSession) {
        self.session = session
    }

    func startService(at url: URL, handler: @escaping (ServiceResult) -> Void) {
        inFlight = true
        session.dataTaskPublisher(for: url)
            .timeout(.seconds(timeOut), scheduler: DispatchQueue.main)
            .map(\.data)
            .receive(on: DispatchQueue.main)
            .sink(receiveCompletion: { [weak self] completion in
                self?.inFlight = false
              if case .failure(let error) = completion {
                  handler(.failure(ServiceError(errorDescription: error.localizedDescription)))
              }
            }, receiveValue: { data in
                handler(.success(data))
            })
            .store(in: &subscribers)
    }
}
