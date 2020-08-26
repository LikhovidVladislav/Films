//
//  ApplicationCoordinator.swift
//  FIlmsTest
//
//  Created by Влад Лиховид on 26.08.2020.
//  Copyright © 2020 Влад Лиховид. All rights reserved.
//

import UIKit

final class ApplicationCoordinator: BaseCoordinator {
    
    var navigationController: UINavigationController
    
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    override func start() {
        runFilmFlow()
    }
    
    private func runFilmFlow() {
        let filmsCoorditator = FilmsCoordinator(navigationController: navigationController)
        self.addDependency(filmsCoorditator)
        filmsCoorditator.start()
        
    }
}
