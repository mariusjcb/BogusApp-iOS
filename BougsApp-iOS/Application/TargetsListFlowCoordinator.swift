//
//  TargetsListFlowCoordinator.swift
//  BougsApp-iOS
//
//  Created by Marius Ilie on 23/01/2021.
//

import UIKit
import BogusApp_Common_Models
import BogusApp_Features_TargetsList
import BogusApp_Features_ChannelsList

public protocol TargetsListFlowCoordinatorDependencies {
    func makeTargetsListViewController(actions: TargetsListViewModelActions) -> TargetsListViewController
    func makeChannelsListViewController(for targets: [TargetSpecific], actions: ChannelsListViewModelActions) -> ChannelsListViewController
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
        let actions = ChannelsListViewModelActions(showPlansSelector: showPlansSelector, showCampaignReview: showCampaignReview)
        let vc = dependencies.makeChannelsListViewController(for: targets, actions: actions)
        navigationController?.pushViewController(vc, animated: true)
    }
    
    private func showPlansSelector(_ plans: [Plan], _ didSelect: @escaping (Int) -> Void) {
        didSelect(1)
    }
    
    private func showCampaignReview(_ targets: [TargetSpecific], selectedPlans: [(Channel, Int)]) {
        fatalError("WORKS")
    }
}
