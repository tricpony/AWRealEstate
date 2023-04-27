//
//  Film.swift
//  AWRealEstate
//
//  Created by aarthur on 4/26/23.
//

import Foundation

struct Film: Codable {
    let title: String
    let cast: [Actor]
    
    private enum CodingKeys: String, CodingKey {
        case title = "Heading"
        case cast = "RelatedTopics"
    }

    var orderedCast: [Actor] {
        cast.sorted { $0.name < $1.name }
    }
}
