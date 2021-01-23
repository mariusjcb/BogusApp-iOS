//
//  TargetsListViewController.swift
//  BougsApp-iOS
//
//  Created by Marius Ilie on 23/01/2021.
//

import UIKit
import BogusApp_Features_TargetsList

public final class TargetsListViewController: UIViewController, StoryboardInstantiable, Alertable, UITableViewDelegate, UITableViewDataSource {
    var viewModel: TargetsListViewModel!
    
    @IBOutlet private weak var tableView: UITableView!
    
    static func create(with viewModel: TargetsListViewModel) -> TargetsListViewController {
        let vc = TargetsListViewController.instantiateViewController()
        vc.viewModel = viewModel
        return vc
    }
    
    public override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
        bind(to: viewModel)
    }
    
    private func setupViews() {
        tableView.delegate = self
        tableView.dataSource = self
    }
    
    private func bind(to viewModel: TargetsListViewModel) {
        viewModel.itemsObservable.observe(on: self) { [weak self] _ in self?.tableView.reloadData() }
        viewModel.errorObservable.observe(on: self) { [weak self] in self?.showError($0) }
    }
    
    private func showError(_ error: String) {
        guard !error.isEmpty else { return }
        showAlert(message: error)
    }
    
    // MARK: - Actions
    
    @IBAction private func didTapNextButton() {
        viewModel.didTapNext()
    }
    
    // MARK: - Delegate & Datasource
    
    public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.itemsObservable.wrappedValue.count
    }
    
    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: TargetsListItemCell.reuseIdentifier, for: indexPath) as! TargetsListItemCell
        cell.configure(with: viewModel.itemsObservable.wrappedValue[indexPath.row])
        return cell
    }
    
    public func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        viewModel.didSelectItem(at: indexPath.row)
    }
}
