//
//  NetworkManager.swift
//  WeatherDataBase
//
//  Created by MacBook on 18.10.21.
//
typealias Failure = (() -> ())?

import Foundation
import Moya_ObjectMapper
import Moya
import SwiftUI

class NetworkManager {
    let provider = MoyaProvider<WeatherAPI>(plugins: [NetworkLoggerPlugin()])
    private init() {}
    static let shared = NetworkManager()
    
    
    func getWeather(lat: Double, lon: Double, completionBlock:((Weather) -> ())?, failureBlock: Failure) {
        provider.request(.getWeather(lat: lat, lon: lon)) { result in
            switch result {
            case .success(let response):
                guard let weather = try? response.mapObject(Weather.self) else {
                    failureBlock?()
                    return
                }
                completionBlock?(weather)
            case.failure(let error):
                failureBlock?()
                print("Error, reason: \(error.localizedDescription)")
            }
        }
    }
}




