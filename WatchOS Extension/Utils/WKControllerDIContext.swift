//
//  WKControllerDIContext.swift
//  WatchOS Extension
//
//  Created by Marius Ilie on 24/01/2021.
//

import Foundation

protocol WKControllerDIContext: class {
    associatedtype ViewModel
    var viewModel: ViewModel { get }
}

class DefaultControllerContext<ViewModel>: WKControllerDIContext {
    var viewModel: ViewModel

    init(viewModel: ViewModel) {
        self.viewModel = viewModel
    }
}

struct ControllerDefinition<Context: AnyObject> {
    let name: String
    let context: Context
}
