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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        GMSServices.provideAPIKey("AIzaSyAS6qgX2yi3HcDVg_Um0ScpBP4wkp3R5pM")
        configureInterface()
    }
    
    private func configureInterface() {
        let camera = GMSCameraPosition.camera(withLatitude: 53.893009, longitude: 27.567444, zoom: 5.0)
        let mapView = GMSMapView.map(withFrame: view.frame, camera: camera)
        view.addSubview(mapView)
        
        let spinner = UIActivityIndicatorView(style: .large)
        spinner.isHidden = true
        view.addSubview(spinner)
        spinner.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.centerY.equalToSuperview()
        }
        
        let watchHistoryButton = UIButton(type: .system)
        watchHistoryButton.setTitle("Watch history", for: .normal)
        watchHistoryButton.setTitleColor(.systemBlue, for: .normal)
        view.addSubview(watchHistoryButton)
        watchHistoryButton.snp.makeConstraints { make in
            make.right.equalToSuperview().inset(16)
            make.top.equalToSuperview().inset(50)
        }
        
       
        
        let deleteAllButton = UIButton(type: .system)
        deleteAllButton.setTitle("Delete All", for: .normal)
        deleteAllButton.setTitleColor(UIColor.systemBlue, for: .normal)
        view.addSubview(deleteAllButton)
        deleteAllButton.snp.makeConstraints { make in
            make.left.equalToSuperview().inset(16)
            make.top.equalToSuperview().inset(50)
        }
    }
    
    func MakeUrlResponse() {
        let session = URLSession.shared
        guard let url = URL(string: "https://api.openweathermap.org/data/2.5/weather") else { return }
        let task = session.dataTask(with: url) { data, response, error in
            if let error = error {
                print("Error")
            }
            do {
                if  let repsonse = response {
                    print("your response\(response)")
                }
            }
        }
    }
    
    //extension MapVC: GMSMapViewDelegate {
    //    func mapView(_ mapView: GMSMapView, didTapAt coordinate: CLLocationCoordinate2D) {
    //        spinner.startAnimating()
    //        NetworkManager.shared.getWeather(lat: coordinate.latitude, lon: coordinate.longitude) { weather in
    //            RealmManager.shared.save(weather: weather)
    //            self.spinner.stopAnimating()
    //        } failureBlock: {
    //            self.spinner.stopAnimating()
    //        }
    //    }
}


