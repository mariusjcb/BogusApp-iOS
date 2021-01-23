//
//  ChannelsViewController.swift
//  BougsApp-iOS
//
//  Created by Marius Ilie on 23/01/2021.
//

import UIKit
import BogusApp_Features_ChannelsList

public final class ChannelsListViewController: UIViewController, StoryboardInstantiable, Alertable, UITableViewDelegate, UITableViewDataSource {
    var viewModel: ChannelsListViewModel!
    
    @IBOutlet private weak var tableView: UITableView!
    
    static func create(with viewModel: ChannelsListViewModel) -> ChannelsListViewController {
        let vc = ChannelsListViewController.instantiateViewController()
        vc.viewModel = viewModel
        return vc
    }
    
    public override func viewDidLoad() {
        super.viewDidLoad()
        navigationController?.navigationBar.prefersLargeTitles = true
        setupViews()
        bind(to: viewModel)
    }
    
    private func setupViews() {
        view.backgroundColor = UIColor.appBackground
        tableView.backgroundColor = UIColor.appBackground
        tableView.delegate = self
        tableView.dataSource = self
    }
    
    private func bind(to viewModel: ChannelsListViewModel) {
        viewModel.itemsObservable.observe(on: self) { [weak self] _ in self?.tableView.reloadData() }
        viewModel.errorObservable.observe(on: self) { [weak self] in self?.showError($0) }
    }
    
    private func showError(_ error: String) {
        guard !error.isEmpty else { return }
        showAlert(message: error, customActions: [ "Reset selection": (.destructive, { [weak self]_ in
            self?.viewModel.didTapReset()
        })])
    }
    
    // MARK: - Actions
    
    @IBAction private func didTapNextButton() {
        viewModel.didTapNext()
    }
    
    @IBAction private func didTapResetButton() {
        viewModel.didTapReset()
    }
    
    // MARK: - Delegate & Datasource
    
    public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.itemsObservable.wrappedValue.count
    }
    
    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: ChannelsListItemCell.reuseIdentifier, for: indexPath) as! ChannelsListItemCell
        cell.configure(with: viewModel.itemsObservable.wrappedValue[indexPath.row])
        return cell
    }
    
    public func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        viewModel.didSelectItem(at: indexPath.row)
    }
    
    public func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        UITableView.automaticDimension
    }
}
