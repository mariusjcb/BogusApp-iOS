//
//  TargetsListFlowCoordinator.swift
//  BougsApp-iOS
//
//  Created by Marius Ilie on 23/01/2021.
//

import UIKit
import WatchConnectivity
import MessageUI
import BogusApp_Common_Models
import BogusApp_Features_TargetsList
import BogusApp_Features_ChannelsList
import BogusApp_Features_PlansList
import BogusApp_Features_CampaignReview

public protocol TargetsListFlowCoordinatorDependencies {
    func makeTargetsListViewController(actions: TargetsListViewModelActions) -> TargetsListViewController
    func makeChannelsListViewController(for targets: [TargetSpecific], actions: ChannelsListViewModelActions) -> ChannelsListViewController
    func makePlansListViewController(for channel: Channel, plans: [Plan], didSelect: @escaping (Int) -> Void) -> PlansListViewController
    func makeCampaignReviewViewController(for targets: [TargetSpecific],
                                          selectedPlans: [(Channel, Int)],
                                          actions: CampaignReviewViewModelActions) -> CampaignReviewViewController
}

public final class TargetsListFlowCoordinator: NSObject, WCSessionDelegate {
    
    private weak var navigationController: UINavigationController?
    private let dependencies: TargetsListFlowCoordinatorDependencies
    
    private weak var targetsListController: TargetsListViewController?
    
    init(navigationController: UINavigationController, dependencies: TargetsListFlowCoordinatorDependencies) {
        self.navigationController = navigationController
        self.dependencies = dependencies
        
        super.init()
        
        if WCSession.isSupported() {
            let session = WCSession.default
            session.delegate = self
            session.activate()
        }
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
    
    private func showPlansSelector(_ channel: Channel, _ plans: [Plan], _ didSelect: @escaping (Int) -> Void) {
        let vc = dependencies.makePlansListViewController(for: channel, plans: plans, didSelect: didSelect)
        vc.viewModel.didSelect = { index in
            didSelect(index)
            vc.dismiss(animated: true)
        }
        navigationController?.present(vc, animated: true)
    }
    
    private func showCampaignReview(_ targets: [TargetSpecific], selectedPlans: [(Channel, Int)]) {
        let actions = CampaignReviewViewModelActions(sendEmail: sendEmail)
        let vc = dependencies.makeCampaignReviewViewController(for: targets, selectedPlans: selectedPlans, actions: actions)
        navigationController?.pushViewController(vc, animated: true)
    }
    
    private func sendEmail(_ toEmail: String, _ message: String) {
        guard MFMailComposeViewController.canSendMail() else { return }
        let mail = MFMailComposeViewController()
        mail.mailComposeDelegate = mail
        mail.setToRecipients([toEmail])
        mail.setMessageBody(message, isHTML: false)
        navigationController?.present(mail, animated: true)
    }
    
    // MARK: - WCSessionDelegate
    public func session(_ session: WCSession, didReceiveMessage message: [String : Any]) {
        guard let destination = message["to"] as? String,
              let message = message["message"] as? String else { return }
        sendEmail(destination, message)
    }
    
    public func session(_ session: WCSession, activationDidCompleteWith activationState: WCSessionActivationState, error: Error?) { }
    public func sessionDidBecomeInactive(_ session: WCSession) { }
    public func sessionDidDeactivate(_ session: WCSession) { }
    
}
