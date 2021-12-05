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
    
    override func awakeFromNib() {
        super.awakeFromNib()
   
    }
}

func setupCell(weather: Weather) {
    
}
    
    
    //    func setupCell(weather: WeatherSaveItem) {
    //        cityLabel.text = ("Населенный пункт: \(weather.city)")
    //        tempLabel.text = ("Температура: \(weather.temp)")
    //        pressureLabel.text = ("Давление: \(weather.pressure)")
    //        let flag = countryFlag(country: weather.country)
    //        countryLabel.text = ("Страна: \(weather.country)\(flag)")
    //        descriptionLabel.text = ("\(weather.main),  \(weather.weatherDesc)")
    //        guard let url = URL(string: "http://openweathermap.org/img/wn/\(weather.icon)@2x.png") else { return }
    //        weatherImage.sd_setImage(with: url)
    //    }
// ДЕЛАЕТ ЭМОДЗИ НЕ ИМЕЙДЖ!!!!!!
private func countryFlag(country:String) -> String {
    let base : UInt32 = 127397
    var flag = ""
    for v in country.unicodeScalars {
        flag.unicodeScalars.append(UnicodeScalar(base + v.value)!)
    }
    return String(flag)
}

