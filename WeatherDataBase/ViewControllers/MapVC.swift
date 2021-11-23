//
//  ViewController.swift
//  WeatherDataBase
//
//  Created by MacBook on 18.10.21.
//

import UIKit
import GoogleMaps

class MapVC: UIViewController {
    @IBOutlet weak var mapView: GMSMapView!
    @IBOutlet weak var spinner: UIActivityIndicatorView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        mapView.delegate = self
    }
    
    @IBAction func deleteAction(_ sender: Any) {
        RealmManager.shared.eraseAll()
    }
    
    @IBAction func showData(_ sender: Any) {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        guard let tableVC = storyboard.instantiateViewController(withIdentifier: String(describing: TableVC.self)) as? TableVC else { return }
        navigationController?.pushViewController(tableVC, animated: true)
    }
}

extension MapVC: GMSMapViewDelegate {
    func mapView(_ mapView: GMSMapView, didTapAt coordinate: CLLocationCoordinate2D) {
        spinner.startAnimating()
        NetworkManager.shared.getWeather(lat: coordinate.latitude, lon: coordinate.longitude) { weather in
            RealmManager.shared.save(weather: weather)
            self.spinner.stopAnimating()
        } failureBlock: {
            self.spinner.stopAnimating()
        }
    }
}


