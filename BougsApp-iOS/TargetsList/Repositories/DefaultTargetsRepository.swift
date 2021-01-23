//
//  TargetsRepository.swift
//  BougsApp-iOS
//
//  Created by Marius Ilie on 22/01/2021.
//

import Foundation
import BogusApp_Common_Models

/// Fetches data from Targets service or database / cache
public protocol TargetsRepository {
    @discardableResult
    func fetchTargets(ids: [UUID], completion: @escaping (Result<[TargetSpecific], Error>) -> Void) -> Cancellable?
}

/// Default implementation of **TargetsRepository**
public final class DefaultTargetsRepository: TargetsRepository {
    
    private let targetsService: DataTransferService
    private let endpointsProvider: TargetsServiceEndpointsQueryable

    init(targetsService: DataTransferService, endpointsProvider: TargetsServiceEndpointsQueryable) {
        self.targetsService = targetsService
        self.endpointsProvider = endpointsProvider
    }
    
    // MARK: - Targets Repository
    
    public func fetchTargets(ids: [UUID], completion: @escaping (Result<[TargetSpecific], Error>) -> Void) -> Cancellable? {
        let task = RepositoryTask()
        task.networkTask = self.targetsService.request(with: endpointsProvider.targetsListEndpoint(ids: ids)) { completion($0.mapError { $0 as Error }) }
        return task
    }
    
}
