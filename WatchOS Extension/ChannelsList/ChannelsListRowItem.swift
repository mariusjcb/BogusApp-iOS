//
//  ChannelsListRowItem.swift
//  WatchOS Extension
//
//  Created by Marius Ilie on 24/01/2021.
//

import WatchKit
import BogusApp_Features_ChannelsList

final class ChannelsListRowItem: NSObject {

    static let reuseIdentifier = String(describing: ChannelsListRowItem.self)

    @IBOutlet private weak var channelTitleLabel: WKInterfaceLabel!
    @IBOutlet private weak var selectedPlanLabel: WKInterfaceLabel!

    private var viewModel: ChannelsListItemViewModel!

    func configure(with viewModel: ChannelsListItemViewModel) {
        self.viewModel = viewModel

        channelTitleLabel.setText(viewModel.name)
        selectedPlanLabel.setHidden(viewModel.selectedPlan == nil)
        selectedPlanLabel.setText(String(format: NSLocalizedString("Monthly fee: %g€", comment: ""),
                                         viewModel.selectedPlan?.price ?? 0))
    }
}
