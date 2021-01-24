//
//  PlansListItemCell.swift
//  BougsApp-iOS
//
//  Created by Marius Ilie on 24/01/2021.
//

import UIKit
import BogusApp_Features_PlansList

public final class PlansListItemCell: UICollectionViewCell, UITableViewDataSource {
    
    static let reuseIdentifier = String(describing: PlansListItemCell.self)
    
    @IBOutlet private weak var neumorphicViewContainer: NeumorphicView!
    @IBOutlet private weak var channelNameLabel: UILabel!
    @IBOutlet private weak var priceLabel: UILabel!
    @IBOutlet private weak var tableView: UITableView!

    private var viewModel: PlansListItemViewModel!
    
    private var benefitsDataSource: [String] { viewModel?.benefits ?? [] }
    
    public override var isHighlighted: Bool {
        get { false }
        set { super.isHighlighted = false }
    }
    
    public override var isSelected: Bool {
        get { false }
        set { super.isSelected = false }
    }
    
    public override func prepareForReuse() {
        super.prepareForReuse()
        self.viewModel = nil
        tableView.reloadData()
    }
    
    public override func awakeFromNib() {
        super.awakeFromNib()
        contentView.backgroundColor = .clear
        contentView.clipsToBounds = false
        backgroundColor = .clear
        clipsToBounds = false
    }

    func configure(with viewModel: PlansListItemViewModel) {
        self.viewModel = viewModel
        channelNameLabel.text = viewModel.channelName
        priceLabel.text = viewModel.price
        tableView.reloadData()
    }
    
    public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        benefitsDataSource.count
    }
    
    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: PlanBenefitTableViewCell.reuseIdentifier, for: indexPath) as! PlanBenefitTableViewCell
        cell.configure(with: benefitsDataSource[indexPath.row])
        return cell
    }
}

