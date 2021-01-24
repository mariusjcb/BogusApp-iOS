//
//  PlanBenefitTableViewCell.swift
//  BougsApp-iOS
//
//  Created by Marius Ilie on 24/01/2021.
//

import UIKit

public final class PlanBenefitTableViewCell: UITableViewCell {
    
    static let reuseIdentifier = String(describing: PlanBenefitTableViewCell.self)
    
    @IBOutlet private weak var benefitLable: UILabel!

    func configure(with benefit: String) {
        self.benefitLable.text = benefit
    }
}
