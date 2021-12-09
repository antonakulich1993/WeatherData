//
//  TableVC.swift
//  WeatherDataBase
//
//  Created by MacBook on 18.10.21.
//

import UIKit
import SnapKit

class TableViewController: UIViewController {
    
    var weather: [WeatherSaveItem] = []
    let tableView = UITableView()

    override func viewDidLoad() {
           super.viewDidLoad()
        setupTableView()
        weather = RealmManager.shared.read().reversed()
        registerCell(cells: [WeatherCell.self])
        tableView.dataSource = self
        tableView.delegate = self
        tableView.reloadData()
        
    }
    
    func setupTableView() {
        tableView.frame = view.bounds
        view.addSubview(tableView)
    }
}
extension TableViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return weather.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "WeatherCell", for: indexPath)
        tableView.register(UINib(nibName: "WeatherCell", bundle: nil), forCellReuseIdentifier: "CellFromNib")
        guard let weatherCell = cell as? WeatherCell else { return cell }
        weatherCell.setupCell(weather: weather[indexPath.row])
        return weatherCell
    }
}

extension TableViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let cell = tableView.cellForRow(at: indexPath)
        cell?.selectionStyle = .none
    }
}
extension TableViewController {
    func registerCell(cells: [AnyClass]) {
        for cell in cells {
            let nib = UINib(nibName: String(describing: cell.self), bundle: nil)
            tableView.register(nib, forCellReuseIdentifier: String(describing: cell.self))
        }
        
    }
}
