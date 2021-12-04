//
//  WeatherSaveItem.swift
//  WeatherDataBase
//
//  Created by MacBook on 18.10.21.
//

//import Foundation
//import Realm
//import RealmSwift
//
//
//class WeatherSaveItem: Object {
//    @objc dynamic var city = ""
//    @objc dynamic var temp = 0.0
//    @objc dynamic var pressure = 0
//    @objc dynamic var icon = ""
//    @objc dynamic var weatherDesc = ""
//    @objc dynamic var main = ""
//    @objc dynamic var country = ""
//    
//    convenience init(weather: Weather) {
//        self.init()
//        self.city = weather.city
//        self.temp = weather.temp
//        self.pressure = weather.pressure
//        self.country = weather.country
//        guard let subWeather = weather.subWeather?.first else { return }
//        self.icon = subWeather.icon
//        self.weatherDesc = subWeather.description
//        self.main = subWeather.main
//    }
//}
//
//
