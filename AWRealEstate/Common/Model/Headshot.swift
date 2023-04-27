//
//  Headshot.swift
//  AWRealEstate
//
//  Created by aarthur on 4/26/23.
//

import Foundation

struct Headshot: Codable {
    let urlString: String

    private enum CodingKeys: String, CodingKey {
        case urlString = "URL"
    }
}
