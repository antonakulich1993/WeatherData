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
    @IBOutlet weak var tempLabel: UILabel!
    @IBOutlet weak var pressureLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var weatherImage: UIImageView!
    @IBOutlet weak var countryLabel: UILabel!
    
    
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
    }
    
    func flag(country:String) -> String {
        let base : UInt32 = 127397
        var code = ""
        for v in country.unicodeScalars {
            code.unicodeScalars.append(UnicodeScalar(base + v.value)!)
        }
        return String(code)
    }
    
    
    func setupCell(weather: WeatherSaveItem) {
        cityLabel.text = ("Населенный пункт: \(weather.city)")
        tempLabel.text = ("Температура: \(weather.temp)")
        pressureLabel.text = ("Давление: \(weather.pressure)")
        let flag = countryFlag(country: weather.country)
        countryLabel.text = ("Страна: \(weather.country)\(flag)")
        descriptionLabel.text = ("\(weather.main),  \(weather.weatherDesc)")
        guard let url = URL(string: "http://openweathermap.org/img/wn/\(weather.icon)@2x.png") else { return }
        weatherImage.sd_setImage(with: url)
    }
}
// ДЕЛАЕТ ЭМОДЗИ НЕ ИМЕЙДЖ!!!!!!
    private func countryFlag(country:String) -> String {
        let base : UInt32 = 127397
        var flag = ""
        for v in country.unicodeScalars {
            flag.unicodeScalars.append(UnicodeScalar(base + v.value)!)
        }
        return String(flag)
    }

