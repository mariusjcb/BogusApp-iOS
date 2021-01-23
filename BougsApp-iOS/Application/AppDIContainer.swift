//
//  AppDIContainer.swift
//  BougsApp-iOS
//
//  Created by Marius Ilie on 23/01/2021.
//

import Foundation

final class AppDIContainer {
    
    lazy var appConfiguration = AppConfiguration()
    
    // MARK: - Network
    lazy var dataTransferService: DataTransferService = {
        let config = ApiDataNetworkConfig(baseURL: URL(string: appConfiguration.baseURL)!)
        let apiDataNetwork = DefaultNetworkService(config: config)
        return DefaultDataTransferService(with: apiDataNetwork)
    }()
    
    // MARK: - DIContainers of scenes
    func makeTargetsSceneDIContainer() -> TargetsSceneDIContainer {
        let dependencies = TargetsSceneDIContainer.Dependencies(apiDataTransferService: dataTransferService)
        return TargetsSceneDIContainer(dependencies: dependencies)
    }
}
