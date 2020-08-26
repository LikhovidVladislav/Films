//
//  FilmsCoordinator.swift
//  FIlmsTest
//
//  Created by Влад Лиховид on 26.08.2020.
//  Copyright © 2020 Влад Лиховид. All rights reserved.
//

import UIKit

final class FilmsCoordinator: BaseCoordinator {
    
    var navigationController: UINavigationController
    var finishFlow: (() -> ())?
    
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    override func start() {
        showFilms()
    }
    
    private func showFilms() {
        let filmsVC = FilmsListViewController.storyboardViewController()
        filmsVC.onSelectMovie = { [weak self] id in
            self?.showDetail(id: id)
        }
        navigationController.pushViewController(filmsVC, animated: true)
        
    }
    
    private func showDetail(id: Int) {
        let detailVC = DetailFilmViewController.storyboardViewController()
        detailVC.filmId = id
        navigationController.pushViewController(detailVC, animated: true)
    }
}
