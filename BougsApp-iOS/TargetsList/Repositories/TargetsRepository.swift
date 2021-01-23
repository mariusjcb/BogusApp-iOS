//
//  TargetsRepository.swift
//  BougsApp-iOS
//
//  Created by Marius Ilie on 22/01/2021.
//

import Foundation
import BogusApp_Common_Models

/// Used to dynamically manipulate endpoints used in repository
public protocol TargetsServiceEndpointsQueryable {
    var provider: EndpointConfigurable { get set }
    
    /// Should provide an endpoint for given id parameters
    func targetsListEndpoint<T>(ids: [UUID]) -> Endpoint<T>
}

/// Implement this protocol for Targets service requests
public protocol TargetsServiceQueryable: DataTransferService { }

/// Fetches data from Targets service or database / cache
public protocol TargetsRepositoryRepresentable {
    @discardableResult
    func fetchTargets(ids: [UUID], completion: @escaping (Result<[TargetSpecific], Error>) -> Void) -> Cancellable?
}

/// Default implementation of **TargetsRepositoryRepresentable**
public final class DefaultTargetsRepository: TargetsRepositoryRepresentable {
    
    private let targetsService: TargetsServiceQueryable
    private let endpointsProvider: TargetsServiceEndpointsQueryable

    init(targetsService: TargetsServiceQueryable, endpointsProvider: TargetsServiceEndpointsQueryable) {
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
