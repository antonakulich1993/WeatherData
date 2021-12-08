//
//  WeatherCell.swift
//  WeatherDataBase
//
//  Created by MacBook on 18.10.21.
//

import UIKit
import SDWebImage
import SnapKit

class WeatherCell: UITableViewCell {
    var cityLabel = UILabel()
    var countryLabel = UILabel()
    var temperatureLabel = UILabel()
    var descriptionLabel = UILabel()
    var pressureLabel = UILabel()
    let weatherImage = UIImage()
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    func setupCell(weather: WeatherSaveItem) {
        cityLabel.text = ("Населенный пункт: \(weather.city)")
        countryLabel.text = ("Страна: \(weather.country)")
        temperatureLabel.text = ("Температура: \(weather.temp)")
        descriptionLabel.text = ("\(weather.description)")
        pressureLabel.text = ("\(weather.pressure)")
    }
}
    
private func countryFlag(country: String) -> String {
    let base : UInt32 = 127397
    var flag = ""
    for v in country.unicodeScalars {
        flag.unicodeScalars.append(UnicodeScalar(base + v.value)!)
    }
    return String(flag)
}

