//
//  TargetsListRowItem.swift
//  WatchOS Extension
//
//  Created by Marius Ilie on 24/01/2021.
//

import WatchKit
import BogusApp_Features_TargetsList

protocol TargetsListRowItemDelegate: class {
    func didChangeSelectedValue(for viewModel: TargetsListItemViewModel, with value: Bool)
}

final class TargetsListRowItem: NSObject {
    
    weak var delegate: TargetsListRowItemDelegate?
    static let reuseIdentifier = String(describing: TargetsListRowItem.self)
    
    @IBOutlet private weak var targetSelectionSwitch: WKInterfaceSwitch!

    private var viewModel: TargetsListItemViewModel!

    func configure(with viewModel: TargetsListItemViewModel) {
        self.viewModel = viewModel
        
        targetSelectionSwitch.setTitle(viewModel.title)
        targetSelectionSwitch.setOn(viewModel.selected)
    }
    
    @IBAction private func didChangeSwtichValue() {
        viewModel.selected = !viewModel.selected
        delegate?.didChangeSelectedValue(for: viewModel, with: viewModel.selected)
    }
}
