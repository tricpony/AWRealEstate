//
//  API.swift
//  AWRealEstate
//
//  Created by aarthur on 4/26/23.
//

import Foundation

struct API {
    static var serviceAddress: URL {
        guard Environment.environmentName != "Mock" else {
            // forced unwrap allowed only for unit test env
            return Bundle.main.url(forResource: Environment.environmentName, withExtension: "json")!
        }
        return Environment.serviceURL
    }
}
