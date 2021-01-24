//
//  TargetsListInterfaceController.swift
//  BogusApp-WatchOS WatchKit Extension
//
//  Created by Marius Ilie on 24/01/2021.
//

import WatchKit
import BogusApp_Features_TargetsList

public final class TargetsListInterfaceController: WKInterfaceController, TargetsListRowItemDelegate {
    static let reuseIdentifier = String(describing: TargetsListInterfaceController.self)
    
    var viewModel: TargetsListViewModel!
    
    @IBOutlet private weak var tableView: WKInterfaceTable!
    @IBOutlet private weak var loadingLabel: WKInterfaceLabel!
    @IBOutlet private weak var errorLabel: WKInterfaceLabel!
    
    public override func awake(withContext context: Any?) {
        super.awake(withContext: context)
        guard let context = context as? DefaultControllerContext<TargetsListViewModel> else {
            return
        }
        self.viewModel = context.viewModel
        bind(to: viewModel)
    }
    
    private func updateData() {
        let items = viewModel.itemsObservable.wrappedValue
        tableView.setHidden(items.isEmpty)
        tableView.setNumberOfRows(items.count, withRowType: TargetsListRowItem.reuseIdentifier)
        
        for i in 0..<items.count {
            let row = tableView.rowController(at: i) as! TargetsListRowItem
            row.configure(with: items[i])
            row.delegate = self
        }
    }
    
    private func bind(to viewModel: TargetsListViewModel) {
        viewModel.itemsObservable.observe(on: self) { [weak self] _ in self?.updateData() }
        viewModel.errorObservable.observe(on: self) { [weak self] in self?.showError($0) }
        viewModel.loadingObservable.observe(on: self) { [weak self] in self?.loadingLabel.setHidden(!$0) }
    }
    
    private func showError(_ error: String) {
        guard !error.isEmpty else { return }
        errorLabel.setHidden(false)
        errorLabel.setText(error)
    }
    
    // MARK: - Actions
    
    @IBAction private func didTapNextButton() {
        viewModel.didTapNext()
    }
    
    public func didChangeSelectedValue(for viewModel: TargetsListItemViewModel, with value: Bool) {
        let rowIndex = Int(self.viewModel.itemsObservable.wrappedValue.firstIndex(of: viewModel)!)
        self.viewModel.didSelectItem(at: rowIndex)
    }
}
