//
//  Environment.swift
//  AWRealEstate
//
//  Created by aarthur on 4/26/23.
//

import Foundation

public enum Environment {
    enum Keys {
        enum Plist {
            static let serviceKeyURL = "SERVICE_URL"
            static let environmentKeyName = "ENV_NAME"
        }
    }
    
    private static let infoDictionary: [String: Any] = {
        guard let dict = Bundle.main.infoDictionary else {
            fatalError("Config file not found")
        }
        return dict
    }()
    
    static let serviceURL: URL = {
        guard let urlString = Self.infoDictionary[Keys.Plist.serviceKeyURL] as? String else {
            fatalError("Service url setting not found")
        }
        guard let url = URL(string: urlString) else {
            fatalError("Invalid service url")
        }
        return url
    }()
    static let environmentName: String = {
        guard let env = Self.infoDictionary[Keys.Plist.environmentKeyName] as? String else {
            fatalError("Environment setting not found")
        }
        return env
    }()
    
    static var isSimpsons: Bool {
        Self.environmentName == "Simpson"
    }
}
