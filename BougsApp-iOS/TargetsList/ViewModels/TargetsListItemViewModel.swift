//
//  TargetsListItemViewModel.swift
//  BougsApp-iOS
//
//  Created by Marius Ilie on 23/01/2021.
//

import Foundation
import BogusApp_Common_Models

public struct TargetsListItemViewModel {
    public let id: UUID
    
    public let title: String
    
    @Observable
    public var selected: Bool = false
}

extension TargetsListItemViewModel: Equatable {
    public init(target: TargetSpecific) {
        self.id = target.id
        self.title = target.title
    }
    
    public static func == (lhs: TargetsListItemViewModel, rhs: TargetsListItemViewModel) -> Bool {
        return lhs.id == rhs.id
    }
}
