
//  WeatherSaveItem.swift
//  WeatherDataBase
//
//  Created by MacBook on 18.10.21.


import Foundation
import Realm
import RealmSwift


class WeatherSaveItem: Object {
    @objc dynamic var temp = ""
    @objc dynamic var pressure = 0
    @objc dynamic var icon = ""
    @objc dynamic var weatherDesc = ""
    @objc dynamic var main = ""
    @objc dynamic var country = ""
    
    convenience init(weather: WeatherData) {
        self.init()
        self.country = weather.country
        self.weatherDesc = weather.weather.first?.description ?? ""
        //self.temp = weather.temp
    }
}


