//
//  Alertable.swift
//  BougsApp-iOS
//
//  Created by Marius Ilie on 23/01/2021.
//

import UIKit

public protocol Alertable {}
public extension Alertable where Self: UIViewController {
    func showAlert(title: String = "",
                   message: String,
                   preferredStyle: UIAlertController.Style = .alert,
                   customActions: [String: (UIAlertAction.Style, (UIAlertAction) -> ())?]? = nil,
                   completion: (() -> Void)? = nil) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        if let actions = customActions {
            actions.forEach { (key, value) in
                alert.addAction(UIAlertAction(title: key, style: value?.0 ?? .default, handler: value?.1))
            }
        }
        alert.addAction(UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: nil))
        self.present(alert, animated: true, completion: completion)
    }
}
