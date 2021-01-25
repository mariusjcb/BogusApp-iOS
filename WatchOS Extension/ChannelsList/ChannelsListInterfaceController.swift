//
//  ChannelsListInterfaceController.swift
//  WatchOS Extension
//
//  Created by Marius Ilie on 24/01/2021.
//

import WatchKit
import BogusApp_Features_ChannelsList

final class ChannelsListInterfaceController: WKInterfaceController {
    static let reuseIdentifier = String(describing: ChannelsListInterfaceController.self)

    var viewModel: ChannelsListViewModel!

    @IBOutlet private weak var emptyLabel: WKInterfaceLabel!
    @IBOutlet private weak var tableView: WKInterfaceTable!

    override func awake(withContext context: Any?) {
        super.awake(withContext: context)
        guard let context = context as? DefaultControllerContext<ChannelsListViewModel> else {
            return
        }
        self.viewModel = context.viewModel
        bind(to: viewModel)
    }

    private func updateData() {
        let items = viewModel.itemsObservable.wrappedValue
        tableView.setHidden(items.isEmpty)
        tableView.setNumberOfRows(items.count, withRowType: ChannelsListRowItem.reuseIdentifier)

        for index in 0..<items.count {
            guard let row = tableView.rowController(at: index) as? ChannelsListRowItem else { continue }
            row.configure(with: items[index])
        }
    }

    private func bind(to viewModel: ChannelsListViewModel) {
        viewModel.itemsObservable.observe(on: self) { [weak self] _ in self?.updateData() }
        viewModel.errorObservable.observe(on: self) { [weak self] in self?.showError($0) }
    }

    private func showError(_ error: String) {
        guard !error.isEmpty else { return }
        presentAlert(withTitle: error,
                     message: nil,
                     preferredStyle: .sideBySideButtonsAlert,
                     actions: [WKAlertAction(title: "Reset", style: .destructive, handler: { [weak self] in
                        self?.viewModel.didTapReset()
                     }), WKAlertAction(title: "Cancel", style: .cancel, handler: { })])
    }

    override func table(_ table: WKInterfaceTable, didSelectRowAt rowIndex: Int) {
        viewModel.didSelectItem(at: rowIndex)
    }

    // MARK: - Actions

    @IBAction private func didTapNextButton() {
        viewModel.didTapNext()
    }
}
