//
//  TableVC.swift
//  WeatherDataBase
//
//  Created by MacBook on 18.10.21.
//

import UIKit

class TableVC: UIViewController {
    var weather: [WeatherSaveItem] = []
    
    let tableView = UITableView()
    
    override func viewDidLoad() {
           super.viewDidLoad()
        setupTableView()
        tableView.dataSource = self
    }
    
    func setupTableView() {
        tableView.frame = view.bounds
        view.addSubview(tableView)
    }
}
extension TableVC: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return weather.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: String(describing: WeatherCell.self), for: indexPath)
        guard let weatherCell = cell as? WeatherCell else { return cell }
        return weatherCell
    }
}



//    var weather: [WeatherSaveItem] = []
//
//    @IBOutlet weak var tableView: UITableView!
//
//
//        tableView.dataSource = self
//        weather = RealmManager.shared.read().reversed()
//        tableView.reloadData()
//        let nib = UINib(nibName: String(describing: WeatherCell.self), bundle: nil)
//        tableView.register(nib, forCellReuseIdentifier: String(describing: WeatherCell.self))
//    }
//}
//
////extension TableVC: UITableViewDataSource {
//    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
//        return weather.count
//    }
//
//    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
//        let cell = tableView.dequeueReusableCell(withIdentifier: String(describing: WeatherCell.self), for: indexPath)
//        guard let weatherCell = cell as? WeatherCell else { return cell }
//        weatherCell.setupCell(weather: weather[indexPath.row])
//        return weatherCell
//    }
