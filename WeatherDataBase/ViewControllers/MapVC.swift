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
    var weather: WeatherData?
    let spinner = UIActivityIndicatorView(style: .large)
    let googleMap = GMSMapView(frame: .null)
    let deleteAllNavBarItem = UIBarButtonItem(title: "Delete All", style: .plain, target: self, action: #selector(deleteAllTapAction))
    let watchHistoryNavBarItem = UIBarButtonItem(title: "Watch History", style: .plain, target: self, action: #selector(watchHistoryTapAction))
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        configureInterface()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        googleMap.delegate = self
    }
    
    func configureInterface() {
        view.addSubview(googleMap)
        googleMap.snp.makeConstraints { make in
            make.top.equalTo(view.snp_topMargin)
            make.leading.trailing.bottom.equalToSuperview()
        }
        spinner.isHidden = true
        view.addSubview(spinner)
        spinner.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.centerY.equalToSuperview()
        }
        navigationItem.leftBarButtonItem = deleteAllNavBarItem
        navigationItem.rightBarButtonItem = watchHistoryNavBarItem
    }
    
    @objc func watchHistoryTapAction() {
        let tableVC = TableVC()
        navigationController?.pushViewController(tableVC, animated: true)
        
    }
    
    @objc func deleteAllTapAction() {
        RealmManager.shared.eraseAll()
    }
}

extension MapVC: GMSMapViewDelegate {
    func mapView(_ mapView: GMSMapView, didTapAt coordinate: CLLocationCoordinate2D) {
        let API_KEY = "91d72de948c9a6cb82aa807ff6b87804"
        guard let url = URL(string: "https://api.openweathermap.org/data/2.5/weather?lat=\(coordinate.latitude)&lon=\(coordinate.longitude)&appid=\(API_KEY)") else { return
        }
        URLSession.shared.dataTask(with: url) { data, response, error in
            if let httpResponse = response as? HTTPURLResponse {
                print("Status code: \(httpResponse.statusCode)")
            }
            do {
                if let data = data {
                    let result = try JSONDecoder().decode(WeatherData.self, from: data)
                    DispatchQueue.main.async {
                        self.weather = result
                        RealmManager.shared.save(weather: result)
                        print(result)
                    }
                } else {
                    print("No data")
                }
            }catch (let error) {
                print("Error:\(error.localizedDescription)")
            }
        }.resume()
    }
}

