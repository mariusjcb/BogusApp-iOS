//
//  SceneDelegate.swift
//  BougsApp-iOS
//
//  Created by Marius Ilie on 22/01/2021.
//

import UIKit
import BogusApp_Common_UIComponents
import BogusApp_Common_UIComponents_iOS

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?

    let appDIContainer = AppDIContainer()
    var appFlowCoordinator: AppFlowCoordinator?

    func scene(_ scene: UIScene,
               willConnectTo session: UISceneSession,
               options connectionOptions: UIScene.ConnectionOptions) {
        guard let windowScene = (scene as? UIWindowScene) else { return }
        window = UIWindow(windowScene: windowScene)
        let navigationController = UINavigationController()
        navigationController.navigationBar.prefersLargeTitles = true
        window?.rootViewController = navigationController

        appFlowCoordinator = AppFlowCoordinator(navigationController: navigationController,
                                                appDIContainer: appDIContainer)
        appFlowCoordinator?.start()

        window?.makeKeyAndVisible()
    }

}
