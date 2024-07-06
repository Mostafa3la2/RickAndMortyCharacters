//
//  FetchAllCharactersUseCase.swift
//  RickAndMortyCharacters
//
//  Created by Mostafa Alaa on 05/07/2024.
//

import Foundation
import Combine

protocol FetchAllCharactersUseCase {
    func execute() -> AnyPublisher<CharactersPage, Error>
}

final class DefaultFetchAllCharactersUseCase: FetchAllCharactersUseCase {

    private let charactersRepository: CharacterRepository

    init(charactersRepository: CharacterRepository) {
        self.charactersRepository = charactersRepository
    }

    func execute() -> AnyPublisher<CharactersPage, Error> {
        return charactersRepository.getAllCharacters()
    }
}
