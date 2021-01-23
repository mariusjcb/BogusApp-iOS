//
//  Cancellable.swift
//  BougsApp-iOS
//
//  Created by Marius Ilie on 22/01/2021.
//

import Foundation

/// A re-implementation of Combine protocol
public protocol Cancellable {
    
    /// Cancel existing/running task
    func cancel()
}
