//
//  Weather.swift
//  WeatherDataBase
//
//  Created by MacBook on 18.10.21.
//

import Foundation
import ObjectMapper

class Weather: Mappable {
    
    
    var city: String = ""
    var temp: Double = 0.0
    var subWeather: [SubWeather]?
    var pressure: Int = 0
    var country: String = ""
    
    required init?(map: Map) {
        mapping(map: map)
    }
    
    func mapping(map: Map) {
        city        <- map["name"]
        temp        <- map["main.temp"]
        pressure    <- map["main.pressure"]
        subWeather  <- map["weather"]
        country     <- map["sys.country"]
        
    }
}

class SubWeather: Mappable {
    
    
    var icon: String = ""
    var description: String = ""
    var main: String = ""
    
    
    required init?(map: Map) {
        mapping(map: map)
    }
    
    func mapping(map: Map) {
        icon            <- map["icon"]
        description     <- map["description"]
        main            <- map["main"]
    }
}
