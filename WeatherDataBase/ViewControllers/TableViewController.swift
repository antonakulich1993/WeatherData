//
//  TableVC.swift
//  WeatherDataBase
//
//  Created by MacBook on 18.10.21.
//

import UIKit
import SnapKit

class TableViewController: UIViewController {
    
    var weather: [WeatherSaveItem] = RealmManager.shared.read()
      
    lazy var tableView: UITableView = {
        let tableView = UITableView()
        tableView.dataSource = self
        tableView.register(UINib(nibName: String(describing: WeatherCell.self), bundle: nil), forCellReuseIdentifier: WeatherCell.identifier)
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
        guard let cell = tableView.dequeueReusableCell(withIdentifier: WeatherCell.identifier, for: indexPath) as? WeatherCell else { return UITableViewCell() }
        cell.setupCell(weather: weather[indexPath.row])
        return cell
    }
}
