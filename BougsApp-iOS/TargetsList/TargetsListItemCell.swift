//
//  TargetsListItemCell.swift
//  BougsApp-iOS
//
//  Created by Marius Ilie on 23/01/2021.
//

import UIKit
import BogusApp_Features_TargetsList

public protocol TargetsListItemCellDelegate: class {
    func didChangeSelectedValue(for viewModel: TargetsListItemViewModel, with value: Bool)
}

public final class TargetsListItemCell: UITableViewCell {
    
    public weak var delegate: TargetsListItemCellDelegate?
    static let reuseIdentifier = String(describing: TargetsListItemCell.self)
    
    @IBOutlet private weak var neumorphicViewContainer: NeumorphicView!
    @IBOutlet private weak var targetTitleLabel: UILabel!
    @IBOutlet private weak var checkMarkImageView: UIImageView!

    private var viewModel: TargetsListItemViewModel!
    
    public override func awakeFromNib() {
        super.awakeFromNib()
        contentView.backgroundColor = .clear
        contentView.clipsToBounds = false
        backgroundColor = .clear
        clipsToBounds = false
    }

    func configure(with viewModel: TargetsListItemViewModel) {
        self.viewModel = viewModel
        
        targetTitleLabel.text = viewModel.title
        checkMarkImageView.isHidden = !viewModel.selected
        neumorphicViewContainer.updateLayers(pressed: viewModel.selected)
    }
    
    public override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        neumorphicViewContainer.updateLayers(pressed: true)
    }
    
    public override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        viewModel.selected = !viewModel.selected
        checkMarkImageView.isHidden = !viewModel.selected
        neumorphicViewContainer.updateLayers(pressed: viewModel.selected)
        delegate?.didChangeSelectedValue(for: viewModel, with: viewModel.selected)
    }
}
