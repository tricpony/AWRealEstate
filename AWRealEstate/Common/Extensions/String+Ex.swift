//
//  String+Ex.swift
//  AWRealEstate
//
//  Created by aarthur on 4/26/23.
//

//import Foundation
import UIKit

extension String {
    static var zero: String {
        ""
    }
    var localized: String {
        NSLocalizedString(self, comment: "no comment")
    }
    
    func hightlightAttributedString(of stringInside: String,
                                    backgroundColor: UIColor?,
                                    foregroundColor: UIColor?) -> NSAttributedString {
        guard let range = self.range(of: stringInside, options: .caseInsensitive),
              let hightlightColor = backgroundColor,
                let foregroundColor = foregroundColor else { return NSAttributedString(string: self) }
        let nsRange = NSRange(range, in: self)
        let attributedString = NSMutableAttributedString(string: self)
        attributedString.addAttribute(.backgroundColor, value: hightlightColor, range: nsRange)
        attributedString.addAttribute(.foregroundColor, value: foregroundColor, range: nsRange)
        return attributedString
    }
}
