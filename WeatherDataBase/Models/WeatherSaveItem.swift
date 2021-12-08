
//  WeatherSaveItem.swift
//  WeatherDataBase
//
//  Created by MacBook on 18.10.21.


import Foundation
import Realm
import RealmSwift


class WeatherSaveItem: Object {
    @objc dynamic var temp = 0.0
    @objc dynamic var pressure = 0
    @objc dynamic var icon = ""
    @objc dynamic var weatherDesc = ""
    @objc dynamic var country = ""
    @objc dynamic var city = ""
    
    convenience init(weather: WeatherData) {
        self.init()
        self.country = weather.country
        self.weatherDesc = weather.weather.first?.description ?? ""
        self.temp = weather.temp
        self.city = weather.city
        self.icon = weather.weather.first?.icon ?? ""
    }
}


