//
//  AppFlowCoordinator.swift
//  BougsApp-iOS
//
//  Created by Marius Ilie on 23/01/2021.
//

import UIKit

final class AppFlowCoordinator {

    var navigationController: UINavigationController
    private let appDIContainer: AppDIContainer
    
    init(navigationController: UINavigationController, appDIContainer: AppDIContainer) {
        self.navigationController = navigationController
        self.appDIContainer = appDIContainer
    }

    func start() {
        let targetsSceneDIContainer = appDIContainer.makeTargetsSceneDIContainer()
        let flow = targetsSceneDIContainer.makeTargetsListFlowCoordinator(navigationController: navigationController)
        flow.start()
    }
}
