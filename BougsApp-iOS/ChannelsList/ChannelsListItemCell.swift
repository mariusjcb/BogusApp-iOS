//
//  ChannelsListItemCell.swift
//  BougsApp-iOS
//
//  Created by Marius Ilie on 23/01/2021.
//

import UIKit
import BogusApp_Features_ChannelsList

public final class ChannelsListItemCell: UITableViewCell {
    
    static let reuseIdentifier = String(describing: ChannelsListItemCell.self)
    
    @IBOutlet private weak var neumorphicViewContainer: NeumorphicView!
    @IBOutlet private weak var channelTitleLabel: UILabel!
    @IBOutlet private weak var selectedPlanLabel: UILabel!
    @IBOutlet private weak var selectedMarkImageView: UIImageView!

    private var viewModel: ChannelsListItemViewModel!
    
    public override func awakeFromNib() {
        super.awakeFromNib()
        selectionStyle = .none
        contentView.backgroundColor = .clear
        contentView.clipsToBounds = false
        backgroundColor = .clear
        clipsToBounds = false
    }

    func configure(with viewModel: ChannelsListItemViewModel) {
        self.viewModel = viewModel
        
        channelTitleLabel.text = viewModel.name
        selectedPlanLabel.isHidden = viewModel.selectedPlan == nil
        selectedPlanLabel.text = String(format: NSLocalizedString("Monthly fee: %g€", comment: ""), viewModel.selectedPlan?.price ?? 0)
        selectedMarkImageView.isHidden = viewModel.selectedPlan == nil
        neumorphicViewContainer.updateLayers(pressed: viewModel.selectedPlan != nil)
    }
}
