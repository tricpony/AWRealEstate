//
//  Actor.swift
//  AWRealEstate
//
//  Created by aarthur on 4/26/23.
//

import Foundation

struct Actor: Codable {
    let baseURLString: String
    let headshot: Headshot
    let summary: String
    
    private enum CodingKeys: String, CodingKey {
        case baseURLString = "FirstURL"
        case headshot = "Icon"
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
}
