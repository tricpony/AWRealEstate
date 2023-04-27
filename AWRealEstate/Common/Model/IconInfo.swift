//
//  IconInfo.swift
//  AWRealEstate
//
//  Created by aarthur on 4/26/23.
//

import Foundation

struct IconInfo: Codable {
    let imageID: String

    private enum CodingKeys: String, CodingKey {
        case imageID = "URL"
    }
}
