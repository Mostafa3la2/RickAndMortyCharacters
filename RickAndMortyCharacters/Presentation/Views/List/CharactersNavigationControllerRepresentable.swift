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
        let networkManager = DefaultNetworkManager()
        let remoteDataSource = DefaultCharactersRemoteDataSource(networkManager: networkManager)
        let charactersRepo = DefaultCharacterRepository(remoteDataSource: remoteDataSource)
        let fetchAllCharactersUseCase = DefaultFetchAllCharactersUseCase(charactersRepository: charactersRepo)
        let viewModel = CharactersListViewModel(fetchCharactersUseCase: fetchAllCharactersUseCase)
        charsListVC.setupViewModel(viewModel: viewModel)
        return charsListVC
    }
}
