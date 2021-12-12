//
//  WeatherService.swift
//  WeatherDataBase
//
//  Created by MacBook on 4.12.21.
//


struct WeatherData: Decodable {
    enum CodingKeys: String, CodingKey {
        case city = "name"
        case main
        case weather
        case sys
    }
    
    enum CountryCodingKeys: String, CodingKey {
        case country
    }
    enum MainCodingKeys: String, CodingKey {
        case temp
        case pressure
    }
    
    let city: String
    let country: String
    let weather: [Weather]
    let temp: Double
    let pressure: Int
    
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        self.city = try values.decode(String.self, forKey: CodingKeys.city)
        self.weather = try values.decode([Weather].self, forKey: CodingKeys.weather)
        
        let countryValue = try values.nestedContainer(keyedBy: CountryCodingKeys.self, forKey: CodingKeys.sys)
        self.country = try countryValue.decode(String.self, forKey: CountryCodingKeys.country)
        
        let mainValues = try values.nestedContainer(keyedBy: MainCodingKeys.self, forKey: CodingKeys.main)
        self.temp = try mainValues.decode(Double.self, forKey: MainCodingKeys.temp)
        self.pressure = try mainValues.decode(Int.self, forKey: MainCodingKeys.pressure)
    }
}
struct Weather: Decodable {
    let icon: String
    let description: String
}
