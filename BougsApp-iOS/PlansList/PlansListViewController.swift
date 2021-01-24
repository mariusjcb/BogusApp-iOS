//
//  PlansListViewController.swift
//  BougsApp-iOS
//
//  Created by Marius Ilie on 24/01/2021.
//

import UIKit
import BogusApp_Features_PlansList

public final class PlansListViewController: UIViewController, StoryboardInstantiable, Alertable, UICollectionViewDelegate, UICollectionViewDataSource {
    var viewModel: PlansListViewModel!
    
    @IBOutlet private weak var collectionView: UICollectionView!
    
    static func create(with viewModel: PlansListViewModel) -> PlansListViewController {
        let vc = PlansListViewController.instantiateViewController()
        vc.viewModel = viewModel
        return vc
    }
    
    public override func viewDidLoad() {
        super.viewDidLoad()
        navigationController?.navigationBar.prefersLargeTitles = true
        setupViews()
        bind(to: viewModel)
    }
    
    public override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        updateSizes()
    }
    
    private func setupViews() {
        collectionView.delegate = self
        collectionView.dataSource = self
        
        view.backgroundColor = UIColor.appBackground
        updateSizes()
    }
    
    private func updateSizes() {
        let totalSize = view.frame.size
        let cellWith = floor(totalSize.width * 0.7)
        let cellHeight = floor(totalSize.height * 0.7)
        
        let insetX = (view.bounds.width - cellWith) / 2.0
        let layout = collectionView.collectionViewLayout as! UICollectionViewFlowLayout
        layout.itemSize = CGSize(width: cellWith, height: cellHeight)
        collectionView.contentInset = UIEdgeInsets(top: 0, left: insetX, bottom: 0, right: insetX)
        collectionView.reloadData()
    }
    
    private func bind(to viewModel: PlansListViewModel) {
        viewModel.itemsObservable.observe(on: self) { [weak self] _ in self?.collectionView.reloadData() }
    }
    
    public func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        viewModel.itemsObservable.wrappedValue.count
    }
    
    public func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: PlansListItemCell.reuseIdentifier, for: indexPath) as! PlansListItemCell
        cell.configure(with: viewModel.itemsObservable.wrappedValue[indexPath.item])
        return cell
    }
    
    public func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        viewModel.didSelectItem(at: indexPath.item)
    }

}
