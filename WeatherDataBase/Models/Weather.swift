//
//  Weather.swift
//  WeatherDataBase
//
//  Created by MacBook on 18.10.21.
//

import Foundation

public struct Weather {
    let city: String
    let country: String
    let temperature: String
    let description: String
    let iconName: String
    let main: String
    
    init(response: APIResponse) {
        country = response.country
        city = response.city
        temperature = "\(Int(response.main.temp))"
        description = response.weather.first?.description ?? ""
        iconName = response.weather.first?.iconName ?? ""
    }
}
