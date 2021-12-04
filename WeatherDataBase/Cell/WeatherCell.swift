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
        initializeCell()
    }
    func initializeCell() {
        
        let cityLabel = UILabel()
        contentView.addSubview(cityLabel)
        cityLabel.snp.makeConstraints { make in
            make.top.equalToSuperview().inset(20)
            make.left.equalToSuperview().inset(16)
        }
        
        let tempLabel = UILabel()
        contentView.addSubview(tempLabel)
        tempLabel.snp.makeConstraints { make in
            make.top.equalTo(cityLabel).inset(20)
            make.left.equalToSuperview().inset(16)
        }
        
        let pressureLabel = UILabel()
        contentView.addSubview(pressureLabel)
        pressureLabel.snp.makeConstraints { make in
            make.top.equalTo(tempLabel).inset(20)
            make.left.equalToSuperview().inset(16)
        }
        
        let countryLabel = UILabel()
        contentView.addSubview(countryLabel)
        countryLabel.snp.makeConstraints { make in
            make.top.equalTo(pressureLabel).inset(20)
            make.left.equalToSuperview().inset(16)
        }
        let weatherImage = UIImageView()
        contentView.addSubview(weatherImage)
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

