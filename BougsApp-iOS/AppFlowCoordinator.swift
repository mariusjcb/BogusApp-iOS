//
//  AppFlowCoordinator.swift
//  BougsApp
//
//  Created by Marius Ilie on 24/01/2021.
//

import UIKit
import BogusApp_Common_UIComponents
import BogusApp_Common_UIComponents_iOS

public final class AppFlowCoordinator {

    var navigationController: UINavigationController
    private let appDIContainer: AppDIContainer

    public init(navigationController: UINavigationController, appDIContainer: AppDIContainer) {
        self.navigationController = navigationController
        self.appDIContainer = appDIContainer
    }

    public func start() {
        let targetsSceneDIContainer = appDIContainer.makeTargetsSceneDIContainer()
        let flow = targetsSceneDIContainer.makeTargetsListFlowCoordinator(navigationController: navigationController)
        flow.subscribeToWatchConnectivity()
        flow.start()
    }
}
