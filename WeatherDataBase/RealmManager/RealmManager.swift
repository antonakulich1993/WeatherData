
//  RealmManager.swift
//  WeatherDataBase
//
//  Created by MacBook on 18.10.21.


import Foundation
import RealmSwift

class RealmManager  {
    private let realm = try! Realm()
    static let shared = RealmManager()
    private init() {}

    func read() -> [WeatherSaveItem] {
        return Array(realm.objects(WeatherSaveItem.self))
    }
    func save(weather: Weather) {
        try? realm.write {
            realm.add(WeatherSaveItem(weather: weather))
        }
    }
    func eraseAll() {
        try? realm.write {
            realm.deleteAll()
        }
    }
}
