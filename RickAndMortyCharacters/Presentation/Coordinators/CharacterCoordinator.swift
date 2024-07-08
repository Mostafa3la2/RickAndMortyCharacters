//
//  CharacterCoordinator.swift
//  RickAndMortyCharacters
//
//  Created by Mostafa Alaa on 07/07/2024.
//

import UIKit
import SwiftUI

protocol CharacterCoordinatorProtocol {
    func showCharacterDetails(characterDetail: CharacterDetailsModel)
}
class CharacterCoordinator: CharacterCoordinatorProtocol {

    private weak var navigationController: UINavigationController?

    init(navigationController: UINavigationController? = nil) {
        self.navigationController = navigationController
    }

    func showCharacterDetails(characterDetail: CharacterDetailsModel) {
        let characterDetailsView = CharacterDetailsView(characterDetails: characterDetail)
        let hostingController = UIHostingController(rootView: characterDetailsView.ignoresSafeArea())        
        navigationController?.pushViewController(hostingController, animated: true)
    }
}
