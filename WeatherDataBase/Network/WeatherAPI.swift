//
//  NetworkManager.swift
//  WeatherDataBase
//
//  Created by MacBook on 18.10.21.
//

//import Foundation
//import Moya
//
//enum WeatherAPI {
//    case getWeather(lat: Double, lon: Double)
//    
//}
//
//extension WeatherAPI: TargetType {
//    
//    var baseURL: URL {
//        return URL(string: "https://api.openweathermap.org/")!
//    }
//    
//    var path: String {
//        switch self {
//        case .getWeather:
//            return "data/2.5/weather"
//        }
//    }
//    
//    var method: Moya.Method {
//        switch self {
//        case .getWeather:
//            return .get
//        }
//    }
//    
//    var sampleData: Data {
//        Data()
//    }
//    
//    var task: Task {
//        guard let params = parameters else { return .requestPlain }
//        return .requestParameters(parameters: params, encoding: parameterEncoding)
//    }
//    
//    var headers: [String : String]? {
//        return nil
//    }
//    
//    var parameters: [String: Any]? {
//        var params = [String: Any]()
//        switch self {
//        case .getWeather(let lat, let lon):
//            params["lat"] = lat
//            params["lon"] = lon
//            params["appid"] = "91d72de948c9a6cb82aa807ff6b87804"
//        }
//        return params
//    }
//    
//    
//    var parameterEncoding: ParameterEncoding {
//        switch self {
//        case .getWeather:
//            return URLEncoding.queryString
//        }
//    }
//}
