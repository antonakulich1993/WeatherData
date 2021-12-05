//
//  ViewController.swift
//  WeatherDataBase
//
//  Created by MacBook on 18.10.21.
//

import UIKit
import GoogleMaps
import SnapKit
import CloudKit

class MapVC: UIViewController {
    
    var dataTask : URLSessionDataTask?
    var weather: Weather?
    let spinner = UIActivityIndicatorView(style: .large)
    let watchHistoryButton = UIButton(type: .system)
    let deleteAllButton = UIButton(type: .system)
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        GMSServices.provideAPIKey("AIzaSyAS6qgX2yi3HcDVg_Um0ScpBP4wkp3R5pM")
        let camera = GMSCameraPosition.camera(withLatitude: 53.893009, longitude: 27.567444, zoom: 5.0)
        let mapView = GMSMapView.map(withFrame: view.frame, camera: camera)
        view.addSubview(mapView)
        mapView.delegate = self
        configureInterface()
    }
    
    func configureInterface() {
        spinner.isHidden = true
        view.addSubview(spinner)
        spinner.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.centerY.equalToSuperview()
        }
        watchHistoryButton.setTitle("Watch history", for: .normal)
        watchHistoryButton.titleLabel?.font = UIFont.boldSystemFont(ofSize: 20)
        watchHistoryButton.setTitleColor(.blue, for: .normal)
        watchHistoryButton.addTarget(self, action: #selector(watchHistoryTapAction), for: .touchUpInside)
        view.addSubview(watchHistoryButton)
        watchHistoryButton.snp.makeConstraints { make in
            make.right.equalToSuperview().inset(16)
            make.top.equalToSuperview().inset(50)
        }
        deleteAllButton.setTitle("Delete All", for: .normal)
        deleteAllButton.titleLabel?.font = UIFont.boldSystemFont(ofSize: 20)
        deleteAllButton.setTitleColor(.red, for: .normal)
        deleteAllButton.addTarget(self, action: #selector(deleteAllTapAction), for: .touchUpInside)
        view.addSubview(deleteAllButton)
        deleteAllButton.snp.makeConstraints { make in
            make.left.equalToSuperview().inset(16)
            make.top.equalToSuperview().inset(50)
        }
    }
    
    @objc func watchHistoryTapAction(sedner: UIButton!) {
        
    }
    
    @objc func deleteAllTapAction(sender: UIButton!) {
        
    }
}

extension MapVC: GMSMapViewDelegate {
    func mapView(_ mapView: GMSMapView, didTapAt coordinate: CLLocationCoordinate2D) {
        let API_KEY = "91d72de948c9a6cb82aa807ff6b87804"
        guard let url = URL(string: "https://api.openweathermap.org/data/2.5/weather?lat=\(coordinate.latitude)&lon=\(coordinate.longitude)&appid=\(API_KEY)") else {
            return
        }
        dataTask?.cancel()
        dataTask = URLSession.shared.dataTask(with: url) { data, response, error in
            guard let data = data else { return }
            if let decodedData = try? JSONDecoder().decode(APIResponse.self, from: data) {
                DispatchQueue.main.async {
                    self.weather = decodedData
                }
            }
        }
        dataTask?.resume()
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
}
