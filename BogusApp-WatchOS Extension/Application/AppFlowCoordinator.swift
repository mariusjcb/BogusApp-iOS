//
//  AppFlowCoordinator.swift
//  BogusApp-WatchOS WatchKit Extension
//
//  Created by Marius Ilie on 24/01/2021.
//

import Foundation

final class AppFlowCoordinator {

    private let appDIContainer: AppDIContainer
    
    init(appDIContainer: AppDIContainer) {
        self.appDIContainer = appDIContainer
    }

    func start() {
        let targetsSceneDIContainer = appDIContainer.makeTargetsSceneDIContainer()
        let flow = targetsSceneDIContainer.makeTargetsListFlowCoordinator()
        flow.start()
    }
}
