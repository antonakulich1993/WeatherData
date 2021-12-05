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
    var backView = UIView()
    var stackView = UIStackView()
    let weatherImage = UIImage()
    
    override func awakeFromNib() {
        super.awakeFromNib()
        configureCell()
    }
        
    func configureCell() {
        contentView.addSubview(backView)
        backView.snp.makeConstraints { make in
            make.top.equalTo(contentView).inset(0)
            make.bottom.equalTo(contentView).inset(0)
            make.left.equalTo(contentView).inset(0)
            make.right.equalTo(contentView).inset(0)
        }
        
       
        let myImageView:UIImageView = UIImageView()
        myImageView.image = weatherImage
        backView.addSubview(myImageView)
        myImageView.snp.makeConstraints { make in
            make.right.equalTo(backView).inset(5)
            make.height.equalTo(70)
            make.width.equalTo(70)
            make.left.equalTo(stackView).inset(10)
            make.centerY.equalTo(countryLabel)
        }
        
        backView.addSubview(stackView)
        stackView.snp.makeConstraints { make in
            make.top.equalTo(backView).inset(5)
            make.bottom.equalTo(backView).inset(5)
            make.right.equalTo(backView).inset(5)
            make.left.equalTo(backView).inset(5)
        }
        stackView.addSubview(cityLabel)
        stackView.addSubview(countryLabel)
        stackView.addSubview(temperatureLabel)
        stackView.addSubview(descriptionLabel)
    }
}
    
private func countryFlag(country:String) -> String {
    let base : UInt32 = 127397
    var flag = ""
    for v in country.unicodeScalars {
        flag.unicodeScalars.append(UnicodeScalar(base + v.value)!)
    }
    return String(flag)
}

