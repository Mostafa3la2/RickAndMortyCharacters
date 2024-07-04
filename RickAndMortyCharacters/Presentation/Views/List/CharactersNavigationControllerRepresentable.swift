//
//  CharactersListViewContollerRepresentable.swift
//  RickAndMortyCharacters
//
//  Created by Mostafa Alaa on 05/07/2024.
//

import UIKit
import SwiftUI

struct CharactersNavigationControllerRepresentable: UIViewControllerRepresentable {

    typealias UIViewControllerType = UINavigationController
    private var navigationController = UINavigationController()
    func makeUIViewController(context: Context) -> UINavigationController {
        setupNavigationController()
        return navigationController
    }

    func updateUIViewController(_ uiViewController: UIViewControllerType, context: Context) {}

    private func setupNavigationController() {
        let charsListVC = CharactersListViewController()
        navigationController.setViewControllers([charsListVC], animated: true)
        setupNavigationControllerAppearance()
    }
    private func setupNavigationControllerAppearance() {
        navigationController.navigationBar.prefersLargeTitles = true
        let standardAppearance = UINavigationBarAppearance()
        standardAppearance.backgroundColor = .white
        standardAppearance.backgroundImage = UIImage()
        navigationController.navigationBar.standardAppearance = standardAppearance
    }
}
