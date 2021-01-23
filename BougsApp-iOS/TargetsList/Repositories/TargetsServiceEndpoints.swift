//
//  TargetsServiceEndpoints.swift
//  BougsApp-iOS
//
//  Created by Marius Ilie on 23/01/2021.
//

import Foundation

/// Used to dynamically manipulate endpoints used in repository
public protocol TargetsServiceEndpointsQueryable {
    func targetsListEndpoint<T>(ids: [UUID]) -> Endpoint<T>
}

public final class DefaultTargetsEndpointProvider: TargetsServiceEndpointsQueryable {
    public func targetsListEndpoint<T>(ids: [UUID]) -> Endpoint<T> {
        DefaultTargetsServiceEndpoints.targets(ids: ids).endpoint()
    }
}
