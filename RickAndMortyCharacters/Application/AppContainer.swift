//
//  AppContainer.swift
//  RickAndMortyCharacters
//
//  Created by Mostafa Alaa on 07/07/2024.
//

import Foundation
import UIKit

class DIContainer {

    static let shared = DIContainer()

    private init() {}
    
    func makeNetworkManager() -> NetworkManager {
        return DefaultNetworkManager()
    }
    func makeCharacterRemoteDataSource() -> CharactersRemoteDataSource {
        return DefaultCharactersRemoteDataSource(networkManager: makeNetworkManager())
    }
    func makeCharacterRepository() -> CharacterRepository {
        return DefaultCharacterRepository(remoteDataSource: makeCharacterRemoteDataSource())
    }
    func makeFetchAllCharactersUseCase() -> FetchAllCharactersUseCase {
        return DefaultFetchAllCharactersUseCase(charactersRepository: makeCharacterRepository())
    }
    func makeCharacterListViewModel() -> CharactersListViewModel {
        return CharactersListViewModel(fetchCharactersUseCase: makeFetchAllCharactersUseCase())
    }

}
