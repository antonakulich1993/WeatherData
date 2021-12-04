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
    
    @objc func watchHistoryTapAction() {
        
    }
    
    @objc func deleteAllTapAction() {
        
    }
}

extension MapVC: GMSMapViewDelegate {
    func mapView(_ mapView: GMSMapView, didTapAt coordinate: CLLocationCoordinate2D) {
        guard let url = URL(string: "api.openweathermap.org/data/2.5/weather?\(coordinate.latitude)={lat}&\(coordinate.longitude)={lon}&appid={91d72de948c9a6cb82aa807ff6b87804}") else { return }
        let session = URLSession.shared
        session.dataTask(with: url) { data, response, error in
            if let response = response {
                print(response)
            }
            guard let data = data else { return }
            print(data)
            
            do {
                let json = try JSONSerialization.jsonObject(with: data, options: [])
                print(json)
            } catch {
                print(error)
            }
        }.resume()
    }
}
