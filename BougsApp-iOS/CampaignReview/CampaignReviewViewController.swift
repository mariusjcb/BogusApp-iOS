//
//  CampaignReviewViewController.swift
//  BougsApp-iOS
//
//  Created by Marius Ilie on 24/01/2021.
//

import UIKit
import BogusApp_Features_CampaignReview

public final class CampaignReviewViewController: UIViewController, StoryboardInstantiable, Alertable, UICollectionViewDelegate, UICollectionViewDataSource {
    var viewModel: CampaignReviewViewModel!
    
    @IBOutlet private weak var targetsLable: UILabel!
    @IBOutlet private weak var collectionView: UICollectionView!
    
    static func create(with viewModel: CampaignReviewViewModel) -> CampaignReviewViewController {
        let vc = CampaignReviewViewController.instantiateViewController()
        vc.viewModel = viewModel
        return vc
    }
    
    public override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
        bind(to: viewModel)
    }
    
    public override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.navigationBar.prefersLargeTitles = false
    }
    
    public override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        collectionView.updateSizing(in: view)
    }
    
    private func setupViews() {
        collectionView.delegate = self
        collectionView.dataSource = self
        
        view.backgroundColor = UIColor.appBackground
        collectionView.updateSizing(in: view)
    }
    
    private func updateData() {
        targetsLable.text = viewModel.targetsStringObservable.wrappedValue
        collectionView.reloadData()
    }
    
    private func bind(to viewModel: CampaignReviewViewModel) {
        viewModel.itemsObservable.observe(on: self) { [weak self] _ in self?.updateData() }
    }
    
    @IBAction private func didTapSendButton() {
        viewModel.didTapSendEmail()
    }
    
    public func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        viewModel.itemsObservable.wrappedValue.count
    }
    
    public func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: PlansListItemCell.reuseIdentifier, for: indexPath) as! PlansListItemCell
        cell.configure(with: viewModel.itemsObservable.wrappedValue[indexPath.item])
        return cell
    }

}
