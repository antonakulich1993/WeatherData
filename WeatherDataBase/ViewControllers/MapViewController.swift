//
//  ViewController.swift
//  WeatherDataBase
//
//  Created by MacBook on 18.10.21.
//

import UIKit
import GoogleMaps
import SnapKit
import Foundation

class MapViewController: UIViewController {
    let spinner: UIActivityIndicatorView = {
        let spinner = UIActivityIndicatorView(style: .large)
        spinner.color = .black
        spinner.hidesWhenStopped = true
        spinner.stopAnimating()
        return spinner
    }()
    let googleMap = GMSMapView(frame: CGRect(x: 0, y: 0, width: 0, height: 0))

    override func viewDidLoad() {
        super.viewDidLoad()
        configureInterface()
        navigationItem.leftBarButtonItem = UIBarButtonItem(title: "Delete all history",
                                                           style: .plain,
                                                           target: self,
                                                           action: #selector(deleteAllTapAction))
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Watch History",
                                                            style: .plain,
                                                            target: self,
                                                            action: #selector(watchHistoryTapAction))
        googleMap.delegate = self
        
    }
    
    func configureInterface() {
        view.addSubview(googleMap)
        googleMap.snp.makeConstraints { make in
            make.top.equalTo(view.snp.topMargin)
            make.leading.trailing.bottom.equalToSuperview()
        }
        view.addSubview(spinner)
        spinner.snp.makeConstraints { make in
            make.center.equalToSuperview()
        }
    }
    
    @objc func watchHistoryTapAction() {
        let tableVC = TableViewController()
        navigationController?.pushViewController(tableVC, animated: true)
        
    }
    
    @objc func deleteAllTapAction() {
        RealmManager.shared.eraseAll()
    }
}

extension MapViewController: GMSMapViewDelegate {
    func mapView(_ mapView: GMSMapView, didTapAt coordinate: CLLocationCoordinate2D) {
        spinner.startAnimating()
        let API_KEY = "91d72de948c9a6cb82aa807ff6b87804"
        var components = URLComponents()
        components.scheme = "https"
        components.host = "api.openweathermap.org"
        components.path = "/data/2.5/weather"
        components.queryItems = [
            URLQueryItem(name: "lat", value: "\(coordinate.latitude)"),
            URLQueryItem(name: "lon", value: "\(coordinate.longitude)"),
            URLQueryItem(name: "appid", value: "\(API_KEY)")
        ]
        guard let url = components.url else { return }
        URLSession.shared.dataTask(with: url) { data, response, error in
            if let httpResponse = response as? HTTPURLResponse {
                print("Status code: \(httpResponse.statusCode)")
            }
            do {
                guard let data = data else { return }
                    let result = try JSONDecoder().decode(WeatherData.self, from: data)
                    DispatchQueue.main.async {
                        RealmManager.shared.save(weather: result)
                        self.spinner.stopAnimating()
                        print(result)
                }
            }catch (let error) {
                print("Error:\(error.localizedDescription)")
            }
        }.resume()
    }
}

