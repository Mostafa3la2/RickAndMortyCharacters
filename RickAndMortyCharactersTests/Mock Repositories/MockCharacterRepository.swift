//
//  MockCharacterRepository.swift
//  RickAndMortyCharactersTests
//
//  Created by Mostafa Alaa on 07/07/2024.
//

import Foundation
import Combine
@testable import RickAndMortyCharacters

class MockCharacterRepository: CharacterRepository {

    var fetchAllCharactersResult: Result<CharactersPage, Error>?

    func getAllCharacters(withParameters parameters: [String : String]) -> AnyPublisher<RickAndMortyCharacters.CharactersPage, Error> {
        return Future { [weak self] promise in
            if let result = self?.fetchAllCharactersResult {
                promise(result)
            }
        }
        .eraseToAnyPublisher()
    }
}
