//
//  CampaignReviewInterfaceController.swift
//  WatchOS Extension
//
//  Created by Marius Ilie on 24/01/2021.
//

import WatchKit
import BogusApp_Features_CampaignReview

final class CampaignReviewInterfaceController: WKInterfaceController {
    static let reuseIdentifier = String(describing: CampaignReviewInterfaceController.self)

    var viewModel: CampaignReviewViewModel!

    @IBOutlet private weak var targetsLabel: WKInterfaceLabel!
    @IBOutlet private weak var tableView: WKInterfaceTable!

    override func awake(withContext context: Any?) {
        super.awake(withContext: context)
        guard let context = context as? DefaultControllerContext<CampaignReviewViewModel> else {
            return
        }
        self.viewModel = context.viewModel
        bind(to: viewModel)
    }

    private func updateData() {
        let items = viewModel.itemsObservable.wrappedValue
        targetsLabel.setText(viewModel.targetsStringObservable.wrappedValue)
        tableView.setHidden(items.isEmpty)
        tableView.setNumberOfRows(items.count, withRowType: PlanListRowItem.reuseIdentifier)

        for index in 0..<items.count {
            guard let row = tableView.rowController(at: index) as? PlanListRowItem else { continue }
            row.configure(with: items[index])
        }
    }

    private func bind(to viewModel: CampaignReviewViewModel) {
        viewModel.itemsObservable.observe(on: self) { [weak self] _ in self?.updateData() }
    }

    @IBAction private func didTapSendButton() {
        viewModel.didTapSendEmail()
    }

}
