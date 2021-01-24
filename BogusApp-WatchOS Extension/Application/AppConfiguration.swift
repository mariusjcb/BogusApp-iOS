//
//  AppConfiguration.swift
//  BogusApp-WatchOS WatchKit Extension
//
//  Created by Marius Ilie on 24/01/2021.
//

import Foundation

final class AppConfiguration {
    lazy var baseURL: String = {
        guard let url = Bundle.main.object(forInfoDictionaryKey: "API_BASE_URL") as? String else {
            fatalError("API_BASE_URL is missing")
        }
        return url
    }()
}
