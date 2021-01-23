//
//  TargetsListFlowCoordinator.swift
//  BougsApp-iOS
//
//  Created by Marius Ilie on 23/01/2021.
//

import UIKit
import BogusApp_Common_Models
import BogusApp_Features_TargetsList

public protocol TargetsListFlowCoordinatorDependencies {
    func makeTargetsListViewController(actions: TargetsListViewModelActions) -> TargetsListViewController
}

public final class TargetsListFlowCoordinator {
    
    private weak var navigationController: UINavigationController?
    private let dependencies: TargetsListFlowCoordinatorDependencies
    
    private weak var targetsListController: TargetsListViewController?
    
    init(navigationController: UINavigationController, dependencies: TargetsListFlowCoordinatorDependencies) {
        self.navigationController = navigationController
        self.dependencies = dependencies
    }
    
    func start() {
        
        let actions = TargetsListViewModelActions(showChannelsForSelectedTarget: showChannelsForSelectedTarget)
        let vc = dependencies.makeTargetsListViewController(actions: actions)

        navigationController?.pushViewController(vc, animated: false)
        targetsListController = vc
    }

    private func showChannelsForSelectedTarget(_ targets: [TargetSpecific]) {
        fatalError("WORKS")
    }
}
