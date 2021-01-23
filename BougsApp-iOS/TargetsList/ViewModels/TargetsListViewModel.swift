//
//  TargetsListViewModel.swift
//  BougsApp-iOS
//
//  Created by Marius Ilie on 23/01/2021.
//

import Foundation
import BogusApp_Common_Models

public struct TargetsListViewModelActions {
    let showChannelsForSelectedTarget: (_ selectedTargets: [TargetSpecific]) -> Void
}

public protocol TargetsListViewModelInput {
    func didSelectItem(at index: Int)
    func didTapNext()
}

public protocol TargetsListViewModelOutput {
    var itemsObservable: Observable<[TargetsListItemViewModel]> { get }
    var loadingObservable: Observable<Bool> { get }
    var errorObservable: Observable<String> { get }
    var title: String { get }
}

public protocol TargetsListViewModel: TargetsListViewModelInput & TargetsListViewModelOutput { }

public final class DefaultTargetsListViewModel: TargetsListViewModel {
    
    private let fetchTargetsListUseCase: FetchTargetsListUseCase
    private let actions: TargetsListViewModelActions
    
    private var targets: [TargetSpecific] = [] {
        didSet { items = targets.map(TargetsListItemViewModel.init) }
    }
    
    public let title = NSLocalizedString("Select specifics...", comment: "")
    
    @Observable private var items: [TargetsListItemViewModel] = []
    @Observable private var loading: Bool = false
    @Observable private var error: String = ""
    
    // MARK: - OUTPUT
    
    public var itemsObservable: Observable<[TargetsListItemViewModel]> { _items }
    public var loadingObservable: Observable<Bool> { _loading }
    public var errorObservable: Observable<String> { _error }
    
    init(fetchTargetsListUseCase: FetchTargetsListUseCase, actions: TargetsListViewModelActions) {
        self.fetchTargetsListUseCase = fetchTargetsListUseCase
        self.actions = actions
        
        fetchTargets()
    }
    
    private func fetchTargets(ids: [UUID] = []) {
        loading = true
        fetchTargetsListUseCase.fetchTargets(ids: ids) { result in
            switch result {
            case .success(let targets):
                self.targets = targets
            case .failure(let error):
                self.error = NSLocalizedString("Failed loading", comment: "") + " [\(error.localizedDescription)]"
            }
            self.loading = false
        }
    }
    
    // MARK: - INPUT
    
    public func didSelectItem(at index: Int) {
        items[index].selected = true
    }
    
    public func didTapNext() {
        let targets = self.items.enumerated().filter { $0.element.selected }.map { self.targets[$0.offset] }
        actions.showChannelsForSelectedTarget(targets)
    }
    
}
