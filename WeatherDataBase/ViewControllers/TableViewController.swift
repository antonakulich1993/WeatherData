//
//  TableVC.swift
//  WeatherDataBase
//
//  Created by MacBook on 18.10.21.
//

import UIKit
import SnapKit

class TableViewController: UIViewController {
    
    lazy var weather: [WeatherSaveItem] = {
        weather = RealmManager.shared.read()
        return weather
    }()
    
    lazy var tableView: UITableView = {
        let tableView = UITableView()
        tableView.dataSource = self
        tableView.register(UINib(nibName: String(describing: WeatherCell.self), bundle: nil), forCellReuseIdentifier: String(describing: WeatherCell.self))
        tableView.estimatedRowHeight = 100
        return tableView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubview(tableView)
        tableView.snp.makeConstraints { make in
            make.top.bottom.left.right.equalToSuperview()
        }
    }
}


extension TableViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return weather.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: String(describing: WeatherCell.self), for: indexPath)
        cell.selectionStyle = .none
        guard let weatherCell = cell as? WeatherCell else { return cell}
        weatherCell.setupCell(weather: weather[indexPath.row])
        return cell
    }
}
