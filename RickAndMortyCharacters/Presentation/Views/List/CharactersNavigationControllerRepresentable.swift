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
        navigationController.setViewControllers([initializeController()], animated: true)
        setupNavigationControllerAppearance()
    }
    private func setupNavigationControllerAppearance() {
        navigationController.navigationBar.prefersLargeTitles = true
        let standardAppearance = UINavigationBarAppearance()
        standardAppearance.backgroundColor = .white
        standardAppearance.backgroundImage = UIImage()
        navigationController.navigationBar.standardAppearance = standardAppearance
    }
    func initializeController() -> UIViewController {
        let charsListVC = CharactersListViewController()
        let viewModel = DIContainer.shared.makeCharacterListViewModel()
        let coordinator = CharacterCoordinator(navigationController: navigationController)
        charsListVC.injectData(viewModel: viewModel, coordinator: coordinator)
        return charsListVC
    }
}
