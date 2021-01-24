//
//  PlansListInterfaceController.swift
//  WatchOS Extension
//
//  Created by Marius Ilie on 24/01/2021.
//

import WatchKit
import BogusApp_Features_PlansList

final class PlansListInterfaceController: WKInterfaceController {
    static let reuseIdentifier = String(describing: PlansListInterfaceController.self)
    
    var viewModel: PlansListViewModel!
    
    @IBOutlet private weak var tableView: WKInterfaceTable!
    
    override func awake(withContext context: Any?) {
        super.awake(withContext: context)
        guard let context = context as? DefaultControllerContext<PlansListViewModel> else {
            return
        }
        self.viewModel = context.viewModel
        bind(to: viewModel)
    }
    
    private func updateData() {
        let items = viewModel.itemsObservable.wrappedValue
        tableView.setHidden(items.isEmpty)
        tableView.setNumberOfRows(items.count, withRowType: PlanListRowItem.reuseIdentifier)
        
        for i in 0..<items.count {
            let row = tableView.rowController(at: i) as! PlanListRowItem
            row.configure(with: items[i])
        }
    }
    
    private func bind(to viewModel: PlansListViewModel) {
        viewModel.itemsObservable.observe(on: self) { [weak self] _ in self?.updateData() }
    }
    
    override func table(_ table: WKInterfaceTable, didSelectRowAt rowIndex: Int) {
        viewModel.didSelectItem(at: rowIndex)
    }

}
