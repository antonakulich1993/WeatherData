//
//  ViewController.swift
//  WeatherDataBase
//
//  Created by MacBook on 18.10.21.
//

import UIKit
import GoogleMaps
import SnapKit

class MapViewController: UIViewController {
    
    var spinner: UIActivityIndicatorView {
        let spinner = UIActivityIndicatorView(style: .large)
        spinner.color = .black
        spinner.hidesWhenStopped = true
        spinner.startAnimating()
        return spinner
    }
    let googleMap = GMSMapView(frame: CGRect(x: 0, y: 0, width: 0, height: 0))
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        configureInterface()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.leftBarButtonItem = UIBarButtonItem(title: "Delete all history",
                                                           style: .plain, target: self,
                                                           action: #selector(deleteAllTapAction))
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Watch History",
                                                            style: .plain, target: self,
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
                        RealmManager.shared.save(weather: result)
                        self.spinner.stopAnimating()
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

