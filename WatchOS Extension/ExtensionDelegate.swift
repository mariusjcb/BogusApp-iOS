//
//  ExtensionDelegate.swift
//  WatchOS Extension
//
//  Created by Marius Ilie on 24/01/2021.
//

import WatchKit
import BogusApp_Features_TargetsList

class ExtensionDelegate: NSObject, WKExtensionDelegate {

    let appDIContainer = AppDIContainer()
    var appFlowCoordinator: AppFlowCoordinator?

    func applicationDidFinishLaunching() {
        appFlowCoordinator = AppFlowCoordinator(appDIContainer: appDIContainer)
        appFlowCoordinator?.start()
    }

    func applicationDidBecomeActive() {
    }

    func applicationWillResignActive() {
    }

}
