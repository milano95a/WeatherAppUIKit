//
//  WeatherTableViewCell.swift
//  WeatherAppUIKit
//
//  Created by Workspace (Abdurakhmon Jamoliddinov) on 26/05/23.
//

import UIKit

class WeatherTableViewCell: UITableViewCell {
    
    @IBOutlet var dateLabel: UILabel!
    @IBOutlet var minTemperatureLabel: UILabel!
    @IBOutlet var maxTemperatureLabel: UILabel!
    

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func configure(with data: WeatherForecast) {
        dateLabel.text = data.dt_txt.getDate()?.getWeekdayString()
        
        minTemperatureLabel.text = "\(data.main.temp_min)°"
        maxTemperatureLabel.text = "\(data.main.temp_max)°"
    }
    
    static let identifier = "WeatherTableViewCell"
    
    static func nib() -> UINib {
        return UINib(nibName: "WeatherTableViewCell", bundle: nil)
    }
}
