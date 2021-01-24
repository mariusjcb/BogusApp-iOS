//
//  UICollectionView+Extensions.swift
//  BougsApp-iOS
//
//  Created by Marius Ilie on 24/01/2021.
//

import UIKit

extension UICollectionView {
    func updateSizing(in view: UIView) {
        let totalSize = view.frame.size
        let cellWith = floor(totalSize.width * 0.7)
        let cellHeight = floor(totalSize.height * 0.7)
        
        let insetX = (view.bounds.width - cellWith) / 2.0
        let layout = self.collectionViewLayout as! UICollectionViewFlowLayout
        layout.itemSize = CGSize(width: cellWith, height: cellHeight)
        self.contentInset = UIEdgeInsets(top: 0, left: insetX, bottom: 0, right: insetX)
        self.reloadData()
    }
}
