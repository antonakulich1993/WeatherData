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
        configureCell()
    }
        
    func configureCell() {
        contentView.addSubview(cityLabel)
        cityLabel.snp.makeConstraints { make in
            make.top.equalToSuperview().inset(10)
            make.left.equalToSuperview().inset(16)
            
        }
        contentView.addSubview(countryLabel)
        cityLabel.snp.makeConstraints { make in
            make.top.equalTo(cityLabel).inset(10)
            make.left.equalToSuperview().inset(16)
            
        }
        contentView.addSubview(temperatureLabel)
        cityLabel.snp.makeConstraints { make in
            make.top.equalTo(countryLabel).inset(10)
            make.left.equalToSuperview().inset(16)
            
        }
        contentView.addSubview(descriptionLabel)
        cityLabel.snp.makeConstraints { make in
            make.top.equalTo(temperatureLabel).inset(10)
            make.left.equalToSuperview().inset(16)
            
        }
        contentView.addSubview(pressureLabel)
        cityLabel.snp.makeConstraints { make in
            make.top.equalTo(descriptionLabel).inset(10)
            make.left.equalToSuperview().inset(16)
            make.bottom.equalToSuperview().inset(5)
            
        }
    }
    
    func setupCell(weather: WeatherSaveItem) {
        cityLabel.text = ("Населенный пункт: \(weather.city)")
        countryLabel.text = ("Страна: \(weather.country)")
        temperatureLabel.text = ("Температура: \(weather.temp)")
        descriptionLabel.text = ("\(weather.description)")
        pressureLabel.text = ("\(weather.pressure)")
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

