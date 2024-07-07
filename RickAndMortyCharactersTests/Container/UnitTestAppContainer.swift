//
//  UnitTestAppContainer.swift
//  RickAndMortyCharactersTests
//
//  Created by Mostafa Alaa on 07/07/2024.
//

import Foundation
@testable import RickAndMortyCharacters

class TestDIContainer {

    static let shared = TestDIContainer()

    private init() {}

    // MARK: - Network Manager
    func makeNetworkManager() -> DefaultNetworkManager {
        return DefaultNetworkManager()
    }
    func makeMockNetworkManager() -> MockNetworkManager {
        return MockNetworkManager()
    }

    // MARK: - Data Sources
    func makeDefaultCharacterDataSource(networkManager: NetworkManager) -> DefaultCharactersRemoteDataSource {
        return DefaultCharactersRemoteDataSource(networkManager: networkManager)
    }

    // MARK: - Repositories
    func makeCharacterRepository(dataSource: CharactersRemoteDataSource) -> DefaultCharacterRepository {
        return DefaultCharacterRepository(remoteDataSource: dataSource)
    }
    func makeMockCharacterRepository() -> MockCharacterRepository {
        return MockCharacterRepository()
    }

    // MARK: - Use Cases
    func makeFetchAllCharactersUseCase(repo: CharacterRepository) -> DefaultFetchAllCharactersUseCase {
        return DefaultFetchAllCharactersUseCase(charactersRepository: repo)
    }

    // MARK: - View Models
    func makeCharacterListViewModel(usecase: FetchAllCharactersUseCase) -> CharactersListViewModel {
        return CharactersListViewModel(fetchCharactersUseCase: usecase)
    }

}
