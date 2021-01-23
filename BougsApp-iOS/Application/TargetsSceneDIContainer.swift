//
//  TargetsSceneDIContainer.swift
//  BougsApp-iOS
//
//  Created by Marius Ilie on 23/01/2021.
//

import UIKit
import SwiftUI
import BogusApp_Common_Models
import BogusApp_Common_Networking
import BogusApp_Features_TargetsList
import BogusApp_Features_ChannelsList

final class TargetsSceneDIContainer {
    
    struct Dependencies {
        let apiDataTransferService: DataTransferService
    }
    
    private let dependencies: Dependencies

    init(dependencies: Dependencies) {
        self.dependencies = dependencies
    }
    
    // MARK: - Use Cases
    func makeFetchTargetsListUseCase() -> FetchTargetsListUseCase {
        return DefaultFetchTargetsListUseCase(targetsRepository: makeTargetsRepository())
    }
    
    // MARK: - Repositories
    func makeTargetsRepository() -> TargetsRepository {
        return DefaultTargetsRepository(targetsService: dependencies.apiDataTransferService,
                                        endpointsProvider: DefaultTargetsEndpointProvider())
    }
    
    // MARK: - Targets List
    func makeTargetsListViewController(actions: TargetsListViewModelActions) -> TargetsListViewController {
        return TargetsListViewController.create(with: makeTargetsListViewModel(actions: actions))
    }
    
    func makeTargetsListViewModel(actions: TargetsListViewModelActions) -> TargetsListViewModel {
        return DefaultTargetsListViewModel(fetchTargetsListUseCase: makeFetchTargetsListUseCase(), actions: actions)
    }
    
    func makeChannelsListViewController(for targets: [TargetSpecific],
                                        actions: ChannelsListViewModelActions) -> ChannelsListViewController {
        return ChannelsListViewController.create(with: makeChannelsListViewModel(for: targets, actions: actions))
    }
    
    func makeChannelsListViewModel(for targets: [TargetSpecific], actions: ChannelsListViewModelActions) -> ChannelsListViewModel {
        return DefaultChannelsListViewModel(targets: targets, actions: actions)
    }
    
    // MARK: - Flow Coordinators
    func makeTargetsListFlowCoordinator(navigationController: UINavigationController) -> TargetsListFlowCoordinator {
        return TargetsListFlowCoordinator(navigationController: navigationController, dependencies: self)
    }
    
}

extension TargetsSceneDIContainer: TargetsListFlowCoordinatorDependencies {}