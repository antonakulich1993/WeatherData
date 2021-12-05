//
//  WeatherService.swift
//  WeatherDataBase
//
//  Created by MacBook on 4.12.21.
//

import Foundation
import CoreLocation
import SwiftUI

public final class WeatherService: NSObject {
    private let locationManager = CLLocationManager()
    private let API_KEY = "91d72de948c9a6cb82aa807ff6b87804"
    private var completionHandler: ((Weather) -> Void)?
    
    public override init() {
        super.init()
        locationManager.delegate = self
        
    }
    
    public func loadWeatherData(_ completionHandler: @escaping((Weather) -> Void)) {
        self.completionHandler = completionHandler
        locationManager.requestWhenInUseAuthorization()
        locationManager.startUpdatingLocation()
        
    }
   // https://api.openweathermap.org/data/2.5/weather?lat={lat}&lon={lon}&appid={API key}
    private func makeDataRequest(forCoordinates coordinates: CLLocationCoordinate2D) {
        guard let urlString = "https://api.openweathermap.org/data/2.5/weather?lat=\(coordinates.latitude)&lon=\(coordinates.longitude)&appid=\(API_KEY)".addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) else { return }
       guard let url = URL(string: urlString) else { return }
        
        URLSession.shared.dataTask(with: url) { data, response, error in
            guard error == nil, let data = data else { return }
            if let response = try? JSONDecoder().decode(APIResponse.self, from: data) {
                self.completionHandler?(Weather(response: response))
            }
        }.resume()
    }
}

extension WeatherService: CLLocationManagerDelegate {
    public func locationManager(
        _ maneger: CLLocationManager,
        didUpdateLocations locations: [CLLocation]
    ) {
        guard let location = locations.first else { return }
        makeDataRequest(forCoordinates: location.coordinate)
    }
    
    public func locationManager(
        _ manager: CLLocationManager,
        didFailWithError error: Error
    ) {
        print("Error\(error.localizedDescription)")
    }
}


struct APIResponse: Decodable {
    let city: String
    let country: String
    let main: APIMain
    let pressuer: Int
    let weather: [APIWeather]
}

struct APIMain: Decodable {
    let temp: Double
}

struct APIWeather: Decodable {
    let description: String
    let iconName: String
    
    enum CodingKeys: String, CodingKey {
        case description
        case iconName = "main"
    }
}

//    var city: String = ""
//    var temp: Double = 0.0
//    var subWeather: [SubWeather]?
//    var pressure: Int = 0
//    var country: String = ""
//
//    required init?(map: Map) {
//        mapping(map: map)
//    }
//
//    func mapping(map: Map) {
//        city        <- map["name"]
//        temp        <- map["main.temp"]
//        pressure    <- map["main.pressure"]
//        subWeather  <- map["weather"]
//        country     <- map["sys.country"]
//
//    }
//}
//
//class SubWeather: Mappable {
//
//
//    var icon: String = ""
//    var description: String = ""
//    var main: String = ""
//
//
//    required init?(map: Map) {
//        mapping(map: map)
//    }
//
//    func mapping(map: Map) {
//        icon            <- map["icon"]
//        description     <- map["description"]
//        main            <- map["main"]
//    }
//}
