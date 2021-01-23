//
//  FetchTargetsUseCase.swift
//  BougsApp-iOS
//
//  Created by Marius Ilie on 22/01/2021.
//

import Foundation
import BogusApp_Common_Models

public protocol FetchTargetsListUseCaseRepresentable: UseCase {
    @discardableResult
    func fetchTargets(ids: [UUID], completion: @escaping (Result<[TargetSpecific], Error>) -> Void) -> Cancellable?
}

public final class DefaultFetchTargetsListUseCase: FetchTargetsListUseCaseRepresentable {
    private let targetsRepository: TargetsRepository
    
    public init(targetsRepository: TargetsRepository) {
        self.targetsRepository = targetsRepository
    }
    
    public func fetchTargets(ids: [UUID], completion: @escaping (Result<[TargetSpecific], Error>) -> Void) -> Cancellable? {
        return targetsRepository.fetchTargets(ids: ids, completion: completion)
    }
}
