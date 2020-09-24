//
//  Extensions.swift
//  CovidTracker
//
//  Created by Ethan. Truong on 2020-09-21.
//  Copyright © 2020 EthanTruong. All rights reserved.
//

import Foundation
import SwiftyJSON

extension JSON {
    
  func toDate(dateFormat: String) -> Date? {
    let dateFormatter = DateFormatter()
    dateFormatter.dateFormat = dateFormat

    let date: Date? = dateFormatter.date(from: self.stringValue)
    return date
    }
}

extension Int {

    func formatNumber() -> String {
        let formatter = NumberFormatter()
        formatter.groupingSeparator = ","
        formatter.numberStyle = .decimal
        return formatter.string(from: NSNumber(value: self))!
    }
}

extension Int64 {
    
    func formatNumber() -> String {
        let formatter = NumberFormatter()
        formatter.groupingSeparator = ","
        formatter.numberStyle = .decimal
        return formatter.string(from: NSNumber(value: self))!
    }
}

extension String {
    
    func formarString() -> Int64{
        let formatter = NumberFormatter()
        formatter.groupingSeparator = ","
        formatter.numberStyle = .decimal
        return Int64(truncating: formatter.number(from: self)!)
    }
    
    func formarString() -> Int{
        let formatter = NumberFormatter()
        formatter.groupingSeparator = ","
        formatter.numberStyle = .decimal
        return Int(truncating: formatter.number(from: self)!)
    }
}
