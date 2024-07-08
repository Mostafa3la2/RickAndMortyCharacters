//
//  PopupMessagePresenter.swift
//  RickAndMortyCharacters
//
//  Created by Mostafa Alaa on 08/07/2024.
//

import UIKit
import SwiftUI

class PopupMessagePresenter {

    static func presentPopupMessage(from viewController: UIViewController?, message: String, displayDuration: TimeInterval = 3, type: MessageType) {
        let popupMessageView = PopupMessageView(message: message, displayDuration: displayDuration, messageType: type)
        let hostingController = UIHostingController(rootView: popupMessageView)

        // Configure the hosting controller view
        hostingController.view.backgroundColor = .clear
        hostingController.view.translatesAutoresizingMaskIntoConstraints = false

        // Add the hosting controller as a child view controller
        viewController?.addChild(hostingController)
        viewController?.view.addSubview(hostingController.view)
        hostingController.didMove(toParent: viewController)

        // Set constraints for the hosting controller's view
        if let viewController {
            NSLayoutConstraint.activate([
                hostingController.view.centerXAnchor.constraint(equalTo: viewController.view.centerXAnchor),
                hostingController.view.bottomAnchor.constraint(equalTo: viewController.view.safeAreaLayoutGuide.bottomAnchor, constant: 20),
                hostingController.view.leadingAnchor.constraint(greaterThanOrEqualTo: viewController.view.leadingAnchor, constant: 20),
                hostingController.view.trailingAnchor.constraint(lessThanOrEqualTo: viewController.view.trailingAnchor, constant: -20)
            ])
        }
        // Remove the hosting controller after the view disappears
        DispatchQueue.main.asyncAfter(deadline: .now() + displayDuration + 1) { // displayDuration + fade-out time
            hostingController.willMove(toParent: nil)
            hostingController.view.removeFromSuperview()
            hostingController.removeFromParent()
        }
    }
}
