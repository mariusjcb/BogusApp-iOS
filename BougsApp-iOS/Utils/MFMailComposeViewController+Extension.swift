//
//  MFMailComposeViewController+Extension.swift
//  BougsApp-iOS
//
//  Created by Marius Ilie on 24/01/2021.
//

import MessageUI

extension MFMailComposeViewController: MFMailComposeViewControllerDelegate {
    public func mailComposeController(_ controller: MFMailComposeViewController, didFinishWith result: MFMailComposeResult, error: Error?) {
        controller.dismiss(animated: true)
    }
}
