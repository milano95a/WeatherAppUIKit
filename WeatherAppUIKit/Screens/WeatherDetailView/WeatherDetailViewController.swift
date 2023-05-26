//
//  DetailViewController.swift
//  WeatherAppUIKit
//
//  Created by Workspace (Abdurakhmon Jamoliddinov) on 26/05/23.
//

import UIKit

class WeatherDetailViewController: UIViewController {
    
    @IBOutlet var collectionView: UICollectionView!
    @IBOutlet var dateLabel: UILabel!
    
    var viewModel: WeatherDetailViewModel!
    var date: Date?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpCollectionView()
        if let date {
            viewModel.load(with: date)
        }
    }
}

extension WeatherDetailViewController: WeatherDetailView {
    func setDate(_ date: String) {
        dateLabel.text = date
    }
    
    func hourlyForecastsUpdated() {
        collectionView.reloadData()
    }
}

extension WeatherDetailViewController: Storyboarded {
    static func instantiate() -> Self {
        let mainStoryboard = UIStoryboard(name: "Main", bundle: Bundle.main)
        return mainStoryboard.instantiateViewController(withIdentifier: "DetailViewController") as! Self
    }
}

extension WeatherDetailViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func setUpCollectionView() {
        collectionView.register(HourlyCollectionViewCell.nib(), forCellWithReuseIdentifier: HourlyCollectionViewCell.identifier)
        collectionView.delegate = self
        collectionView.dataSource = self
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 100, height: 100)
    }

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        viewModel.hourlyForecasts.count
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: HourlyCollectionViewCell.identifier, for: indexPath) as! HourlyCollectionViewCell
        cell.configure(with: viewModel.hourlyForecasts[indexPath.row])
        return cell
    }

}
