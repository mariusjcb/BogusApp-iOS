//
//  CampaignReviewInterfaceController.swift
//  BogusApp-WatchOS WatchKit Extension
//
//  Created by Marius Ilie on 24/01/2021.
//

import WatchKit
import BogusApp_Features_CampaignReview

public final class CampaignReviewInterfaceController: WKInterfaceController {
    static let reuseIdentifier = String(describing: CampaignReviewInterfaceController.self)
    
    var viewModel: CampaignReviewViewModel!
    
    @IBOutlet private weak var targetsLabel: WKInterfaceLabel!
    @IBOutlet private weak var tableView: WKInterfaceTable!
    
    public override func awake(withContext context: Any?) {
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
        
        for i in 0..<items.count {
            let row = tableView.rowController(at: i) as! PlanListRowItem
            row.configure(with: items[i])
        }
    }
    
    private func bind(to viewModel: CampaignReviewViewModel) {
        viewModel.itemsObservable.observe(on: self) { [weak self] _ in self?.updateData() }
    }
    
    @IBAction private func didTapSendButton() {
        viewModel.didTapSendEmail()
    }

}
