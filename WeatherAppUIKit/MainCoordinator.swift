//
//  MainCoordinator.swift
//  WeatherAppUIKit
//
//  Created by Workspace (Abdurakhmon Jamoliddinov) on 26/05/23.
//

import UIKit

protocol Storyboarded {
    static func instantiate() -> Self
}
class MainCoordinator {
    
    weak var vc: UIViewController?
    
    init(_ vc: UIViewController) {
        self.vc = vc
    }
    
    func didSelectWeather(_ date: Date) {
        let detailVC = WeatherDetailViewController.instantiate()
        detailVC.viewModel = WeatherDetailViewModel(detailVC)
        detailVC.date = date
        vc?.navigationController?.pushViewController(detailVC, animated: true)
    }
}
