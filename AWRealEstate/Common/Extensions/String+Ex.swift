//
//  String+Ex.swift
//  AWRealEstate
//
//  Created by aarthur on 4/26/23.
//

import Foundation

extension String {
    static var zero: String {
        ""
    }
    var localized: String {
        NSLocalizedString(self, comment: "no comment")
    }
}