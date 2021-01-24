//
//  TargetsSceneDIContainer.swift
//  WatchOS Extension
//
//  Created by Marius Ilie on 24/01/2021.
//

import WatchKit
import BogusApp_Common_Models
import BogusApp_Common_Networking
import BogusApp_Features_TargetsList
import BogusApp_Features_ChannelsList
import BogusApp_Features_PlansList
import BogusApp_Features_CampaignReview

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
    func makeTargetsListController(actions: TargetsListViewModelActions) -> ControllerDefinition<DefaultControllerContext<TargetsListViewModel>> {
        return .init(name: TargetsListInterfaceController.reuseIdentifier, context: .init(viewModel: makeTargetsListViewModel(actions: actions)))
    }
    
    func makeTargetsListViewModel(actions: TargetsListViewModelActions) -> TargetsListViewModel {
        return DefaultTargetsListViewModel(fetchTargetsListUseCase: makeFetchTargetsListUseCase(), actions: actions)
    }
    
    func makeChannelsListController(for targets: [TargetSpecific],
                                    actions: ChannelsListViewModelActions) -> ControllerDefinition<DefaultControllerContext<ChannelsListViewModel>> {
        return .init(name: ChannelsListInterfaceController.reuseIdentifier,
                     context: .init(viewModel: makeChannelsListViewModel(for: targets, actions: actions)))
    }
    
    func makeChannelsListViewModel(for targets: [TargetSpecific], actions: ChannelsListViewModelActions) -> ChannelsListViewModel {
        return DefaultChannelsListViewModel(targets: targets, actions: actions)
    }
    
    func makePlansListController(for channel: Channel,
                                 plans: [Plan],
                                 didSelect: @escaping (Int) -> Void) -> ControllerDefinition<DefaultControllerContext<PlansListViewModel>> {
        return .init(name: PlansListInterfaceController.reuseIdentifier,
                     context: .init(viewModel: makePlansListViewModel(for: channel, plans: plans, didSet: didSelect)))
    }
    
    func makePlansListViewModel(for channel: Channel, plans: [Plan], didSet: @escaping (Int) -> Void) -> PlansListViewModel {
        return DefaultPlansListViewModel(for: channel, plans: plans, didSelect: didSet)
    }
    
    func makeCampaignReviewController(for targets: [TargetSpecific],
                                      selectedPlans: [(Channel, Int)],
                                      actions: CampaignReviewViewModelActions) -> ControllerDefinition<DefaultControllerContext<CampaignReviewViewModel>> {
        return .init(name: CampaignReviewInterfaceController.reuseIdentifier,
                     context: .init(viewModel: makeCampaignReviewViewModel(for: targets, selectedPlans: selectedPlans, actions: actions)))
    }
    
    func makeCampaignReviewViewModel(for targets: [TargetSpecific],
                                     selectedPlans: [(Channel, Int)],
                                     actions: CampaignReviewViewModelActions) -> CampaignReviewViewModel {
        return DefaultCampaignReviewViewModel(targets: targets, selectedPlans: selectedPlans, actions: actions)
    }
    
    // MARK: - Flow Coordinators
    func makeTargetsListFlowCoordinator() -> TargetsListFlowCoordinator {
        return TargetsListFlowCoordinator(dependencies: self)
    }
    
}

extension TargetsSceneDIContainer: TargetsListFlowCoordinatorDependencies { }
