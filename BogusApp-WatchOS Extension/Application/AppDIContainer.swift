//
//  AppDIContainer.swift
//  BogusApp-WatchOS WatchKit Extension
//
//  Created by Marius Ilie on 24/01/2021.
//

import Foundation
import BogusApp_Common_Networking

final class AppDIContainer {
    
    lazy var appConfiguration = AppConfiguration()
    
    // MARK: - Network
    lazy var dataTransferService: DataTransferService = {
        let config = DefaultNetworkConfiguration(baseURL: URL(string: appConfiguration.baseURL)!)
        let apiDataNetwork = DefaultNetworkService(config: config)
        return DefaultDataTransferService(with: apiDataNetwork)
    }()
    
    // MARK: - DIContainers of scenes
    func makeTargetsSceneDIContainer() -> TargetsSceneDIContainer {
        let dependencies = TargetsSceneDIContainer.Dependencies(apiDataTransferService: dataTransferService)
        return TargetsSceneDIContainer(dependencies: dependencies)
    }
}
