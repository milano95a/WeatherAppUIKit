//
//  HourlyCollectionViewCell.swift
//  WeatherAppUIKit
//
//  Created by Workspace (Abdurakhmon Jamoliddinov) on 26/05/23.
//

import UIKit

class HourlyCollectionViewCell: UICollectionViewCell {
    
    static let identifier = "HourlyCollectionViewCell"
    
    static func nib() -> UINib {
        return UINib(nibName: identifier, bundle: nil)
    }
    
    @IBOutlet var timeLabel: UILabel!
    @IBOutlet var temperatureLabel: UILabel!
    
    func configure(with model: WeatherForecast) {
        timeLabel.text = model.dt_txt.getDate()?.time
        temperatureLabel.text = "\(model.main.temp)".withDegrees
    }

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

}
