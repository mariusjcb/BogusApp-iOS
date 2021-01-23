//
//  TargetsListItemCell.swift
//  BougsApp-iOS
//
//  Created by Marius Ilie on 23/01/2021.
//

import UIKit

public protocol TargetsListItemCellDelegate: class {
    func didChangeSelectedValue(for viewModel: TargetsListItemViewModel, with value: Bool)
}

public final class TargetsListItemCell: UITableViewCell {
    
    public weak var delegate: TargetsListItemCellDelegate?
    static let reuseIdentifier = String(describing: TargetsListItemCell.self)
    
    @IBOutlet private weak var targetTitleLabel: UILabel!
    @IBOutlet private weak var targetSelectedSwitch: UISwitch!

    private var viewModel: TargetsListItemViewModel!

    func configure(with viewModel: TargetsListItemViewModel) {
        self.viewModel = viewModel
        
        targetTitleLabel.text = viewModel.title
        targetSelectedSwitch.isOn = viewModel.selected
    }
    
    @IBAction private func didChangeSwitchValue() {
        viewModel.selected = targetSelectedSwitch.isOn
        delegate?.didChangeSelectedValue(for: viewModel, with: targetSelectedSwitch.isOn)
    }
}
