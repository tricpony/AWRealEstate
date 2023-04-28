//
//  Actor.swift
//  AWRealEstate
//
//  Created by aarthur on 4/26/23.
//

import Foundation

struct Actor: Codable, ImageModel {
    let baseURLString: String
    let iconInfo: IconInfo
    let summary: String
    
    private enum CodingKeys: String, CodingKey {
        case baseURLString = "FirstURL"
        case iconInfo = "Icon"
        case summary = "Text"
    }

    var name: String {
        guard let range = summary.range(of: "-") else {
            return "No name".localized
        }
        return "\(summary.prefix(upTo: range.lowerBound))"
    }
    var role: String {
        guard let range = summary.range(of: "-") else {
            return "No role".localized
        }
        return "\(summary.suffix(from: range.upperBound))"
    }
    var imageURL: URL? {
        guard let baseURL = URL(string: baseURLString),
              let url = URL(string: iconInfo.imageID, relativeTo: baseURL.deletingLastPathComponent() ) else { return .none }
        return url
    }
}
