//
//  WeatherCell.swift
//  WeatherDataBase
//
//  Created by MacBook on 18.10.21.
//

import UIKit
import SDWebImage

class WeatherCell: UITableViewCell {
  
    @IBOutlet weak var cityLabel: UILabel!
    @IBOutlet weak var countryLabel: UILabel!
    @IBOutlet weak var temperatureLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var pressureLabel: UILabel!
    @IBOutlet weak var weatherImage: UIImageView!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    func setupCell(weather: WeatherSaveItem) {
        cityLabel.text = ("Населенный пункт: \(weather.city)")
        countryLabel.text = ("Страна: \(weather.country)\(countryFlag(country: weather.country))")
        temperatureLabel.text = ("Температура: \(weather.temp)")
        descriptionLabel.text = ("\(weather.weatherDesc)")
        pressureLabel.text = ("Давление: \(weather.pressure)")
        guard let url = URL(string: "http://openweathermap.org/img/wn/\(weather.icon)@2x.png") else { return }
        weatherImage.sd_setImage(with: url)
        
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

