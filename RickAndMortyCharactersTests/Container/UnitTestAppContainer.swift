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

    func makeMockCharacterRepository() -> MockCharacterRepository {
        return MockCharacterRepository()
    }

    func makeFetchAllCharactersUseCase(repository: CharacterRepository) -> DefaultFetchAllCharactersUseCase {
        return DefaultFetchAllCharactersUseCase(charactersRepository: repository)
    }
    func makeCharacterListViewModel(useCase: FetchAllCharactersUseCase) -> CharactersListViewModel {
        return CharactersListViewModel(fetchCharactersUseCase: makeFetchAllCharactersUseCase(repository: makeMockCharacterRepository()))
    }

}
