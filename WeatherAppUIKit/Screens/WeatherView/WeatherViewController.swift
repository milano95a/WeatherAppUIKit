//
//  WeatherViewController.swift
//  WeatherAppUIKit
//
//  Created by Workspace (Abdurakhmon Jamoliddinov) on 26/05/23.
//

import UIKit

class WeatherViewController: UIViewController {
        
    @IBOutlet var table: UITableView!
    @IBOutlet var temperatureLabel: UILabel!
    @IBOutlet var descriptionLabel: UILabel!
    
    var viewModel: WeatherViewModel!
    var coordinator: MainCoordinator!
    private var numberOfDays = Int.max

    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel = WeatherViewModel(self)
        coordinator = MainCoordinator(self)
        setupTableView()
        viewModel.load()
        
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(title: "filter", style: .done, target: self, action: #selector(filterTapped))
    }
    
    @objc func filterTapped(sender: UIBarButtonItem) {
        let alert = UIAlertController(title: "Select number of days", message: nil, preferredStyle: .actionSheet)
         
         alert.addAction(UIAlertAction(title: "3 Days", style: .default , handler:{ [weak self] _ in
             self?.numberOfDays = 3
             self?.table.reloadData()
         }))
         
         alert.addAction(UIAlertAction(title: "5 Days", style: .default , handler:{ [weak self] _ in
             self?.numberOfDays = 5
             self?.table.reloadData()
         }))

         alert.addAction(UIAlertAction(title: "7 Days", style: .default , handler:{ [weak self] _ in
             self?.numberOfDays = 7
             self?.table.reloadData()
         }))
         
         alert.addAction(UIAlertAction(title: "Dismiss", style: .cancel, handler:{ _ in
             print("dismiss tapped")
         }))

         self.present(alert, animated: true)
    }
}

extension WeatherViewController: WeatherView {
    func setCurrentWeather(_ temperature: String, _ description: String) { 
        self.temperatureLabel.text = temperature
        self.descriptionLabel.text = description
    }
    
    func dailyForecastUpdated() {
        table.reloadData()
    }
}

extension WeatherViewController: UITableViewDelegate, UITableViewDataSource {
    func setupTableView() {
        table.register(WeatherTableViewCell.nib(), forCellReuseIdentifier: WeatherTableViewCell.identifier)
        table.delegate = self
        table.dataSource = self
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return min(viewModel.dailyForecast.count, numberOfDays)
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: WeatherTableViewCell.identifier, for: indexPath) as! WeatherTableViewCell
        cell.configure(with: viewModel.dailyForecast[indexPath.row])
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if let date = viewModel.dailyForecast[indexPath.row].dt_txt.getDate() {
            coordinator?.didSelectWeather(date)
        }
    }
}
