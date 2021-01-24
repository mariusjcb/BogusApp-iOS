//
//  PlanListRowItem.swift
//  WatchOS Extension
//
//  Created by Marius Ilie on 24/01/2021.
//

import WatchKit
import BogusApp_Features_PlansList

final class PlanListRowItem: NSObject {
    
    static let reuseIdentifier = String(describing: PlanListRowItem.self)
    
    @IBOutlet private weak var channelNameLabel: WKInterfaceLabel!
    @IBOutlet private weak var priceLabel: WKInterfaceLabel!
    @IBOutlet private weak var benefitsLabel: WKInterfaceLabel!

    private var viewModel: PlansListItemViewModel!
    
    private var benefitsJoinedString: String { viewModel?.benefits.joined(separator: "\n") ?? "" }

    func configure(with viewModel: PlansListItemViewModel) {
        self.viewModel = viewModel
        channelNameLabel.setText(viewModel.channelName)
        priceLabel.setText(viewModel.price)
        benefitsLabel.setText(benefitsJoinedString)
    }
}
