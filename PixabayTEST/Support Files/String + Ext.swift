//
//  String + Ext.swift
//  PixabayTEST
//
//  Created by Даурен on 02.02.2022.
//

import UIKit

extension String {
    
    private var firstUppercased: String { return prefix(1).uppercased() + dropFirst() }
    
    func trim() -> String {
        let trimmedString = self.replacingOccurrences(of: " ", with: "+")
        return trimmedString.lowercased()
    }
    
    func tagTrimmer() -> String {
        var trimmedString = ""
        if let index = self.range(of: ",")?.lowerBound {
            let substring = self[..<index]
            trimmedString = String(substring)
        }
        return trimmedString.firstUppercased
    }
}
