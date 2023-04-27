//
//  Constants.swift
//  AWRealEstate
//
//  Created by aarthur on 4/26/23.
//

import UIKit

struct Fixed {
    struct Idiom {
        static var isIpad: Bool {
            UIDevice.current.userInterfaceIdiom == .pad
        }
        static var isIphone: Bool {
            UIDevice.current.userInterfaceIdiom == .phone
        }
    }
}
