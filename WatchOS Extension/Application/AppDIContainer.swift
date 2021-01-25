//
//  AppDIContainer.swift
//  WatchOS Extension
//
//  Created by Marius Ilie on 24/01/2021.
//

import Foundation
import BogusApp_Common_Networking

final class AppDIContainer {

    lazy var appConfiguration = AppConfiguration()

    // MARK: - Network
    lazy var dataTransferService: NetworkService = {
        let config = DefaultNetworkConfiguration(baseURL: URL(string: appConfiguration.baseURL)!)
        return DefaultNetworkService(config: config)
    }()

    // MARK: - DIContainers of scenes
    func makeTargetsSceneDIContainer() -> TargetsSceneDIContainer {
        let dependencies = TargetsSceneDIContainer.Dependencies(networkService: dataTransferService)
        return TargetsSceneDIContainer(dependencies: dependencies)
    }
}
