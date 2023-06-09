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
    var timeOut: TimeInterval = 15
    private let session: URLSession
    private var subscribers = Set<AnyCancellable>()

    init(session: URLSession) {
        self.session = session
    }

    /// Perform arbitrary web service at address *url*.
    /// - Parameters:
    ///   - url: Web address of service.
    ///   - handler: Call back to indicate success or failure associated with payload or error.
    func startService(at url: URL, handler: @escaping (ServiceResult) -> Void) {
        session.dataTaskPublisher(for: url)
            .timeout(.seconds(timeOut), scheduler: DispatchQueue.main)
            .map(\.data)
            .receive(on: DispatchQueue.main)
            .sink(receiveCompletion: { completion in
              if case .failure(let error) = completion {
                  handler(.failure(ServiceError(errorDescription: error.localizedDescription)))
              }
            }, receiveValue: { data in
                handler(.success(data))
            })
            .store(in: &subscribers)
    }
}
