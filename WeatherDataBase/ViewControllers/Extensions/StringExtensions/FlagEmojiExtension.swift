//
//  String+Extension.swift
//  WeatherDataBase
//
//  Created by MacBook on 12.12.21.
//

import Foundation

extension String {
     func countryFlag() -> String {
        let base : UInt32 = 127397
        var flag = ""
        for v in unicodeScalars {
            flag.unicodeScalars.append(UnicodeScalar(base + v.value)!)
        }
        return String(flag)
    }
}
