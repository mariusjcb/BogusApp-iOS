//
//  TargetsListFlowCoordinator.swift
//  BogusApp-WatchOS WatchKit Extension
//
//  Created by Marius Ilie on 24/01/2021.
//

import WatchKit
import BogusApp_Common_Models
import BogusApp_Features_TargetsList
import BogusApp_Features_ChannelsList
import BogusApp_Features_PlansList
import BogusApp_Features_CampaignReview

protocol TargetsListFlowCoordinatorDependencies {
    func makeTargetsListController(actions: TargetsListViewModelActions) -> ControllerDefinition<DefaultControllerContext<TargetsListViewModel>>
    func makeChannelsListController(for targets: [TargetSpecific],
                                    actions: ChannelsListViewModelActions) -> ControllerDefinition<DefaultControllerContext<ChannelsListViewModel>>
    func makePlansListController(for channel: Channel,
                                 plans: [Plan],
                                 didSelect: @escaping (Int) -> Void) -> ControllerDefinition<DefaultControllerContext<PlansListViewModel>>
    func makeCampaignReviewController(for targets: [TargetSpecific],
                                      selectedPlans: [(Channel, Int)],
                                      actions: CampaignReviewViewModelActions) -> ControllerDefinition<DefaultControllerContext<CampaignReviewViewModel>>
}

final class TargetsListFlowCoordinator {
    
    private weak var rootController: WKInterfaceController? { WKExtension.shared().rootInterfaceController }
    private let dependencies: TargetsListFlowCoordinatorDependencies
    
    init(dependencies: TargetsListFlowCoordinatorDependencies) {
        self.dependencies = dependencies
    }
    
    func start() {
        let actions = TargetsListViewModelActions(showChannelsForSelectedTarget: showChannelsForSelectedTarget)
        let cdef = dependencies.makeTargetsListController(actions: actions)

        WKInterfaceController.reloadRootControllers(withNamesAndContexts: [(cdef.name, cdef.context)])
    }

    private func showChannelsForSelectedTarget(_ targets: [TargetSpecific]) {
        let actions = ChannelsListViewModelActions(showPlansSelector: showPlansSelector, showCampaignReview: showCampaignReview)
        let cdef = dependencies.makeChannelsListController(for: targets, actions: actions)
        
        rootController?.pushController(withName: cdef.name, context: cdef.context)
    }
    
    private func showPlansSelector(_ channel: Channel, _ plans: [Plan], _ didSelect: @escaping (Int) -> Void) {
        let cdef = dependencies.makePlansListController(for: channel, plans: plans, didSelect: didSelect)
        cdef.context.viewModel.didSelect = { [weak rootController] index in
            didSelect(index)
            rootController?.pop()
        }
        
        rootController?.pushController(withName: cdef.name, context: cdef.context)
    }
    
    private func showCampaignReview(_ targets: [TargetSpecific], selectedPlans: [(Channel, Int)]) {
        let actions = CampaignReviewViewModelActions(sendEmail: sendEmail)
        let cdef = dependencies.makeCampaignReviewController(for: targets, selectedPlans: selectedPlans, actions: actions)
        rootController?.pushController(withName: cdef.name, context: cdef.context)
    }
    
    private func sendEmail(_ toEmail: String, _ message: String) {
        rootController?.presentAlert(withTitle: "ERROR",
                                     message: "I'm still facing how to use WatchConnectivity with existing iOS app.",
                                     preferredStyle: .alert, actions: [WKAlertAction(title: "OK", style: .cancel, handler: { })])
    }
}
