//
//  MockNetworkManager.swift
//  RickAndMortyCharactersTests
//
//  Created by Mostafa Alaa on 08/07/2024.
//

import Foundation
import Combine
@testable import RickAndMortyCharacters

class MockNetworkManager: NetworkManager {
    var fetchCharactersResult: AnyPublisher<CharactersPageDTO, Error>?

    func fetchAllCharacters(withParameters parameters: [String: String]) -> AnyPublisher<CharactersPageDTO, Error> {
        if let fetchCharactersResult {
            return fetchCharactersResult
        }
        return Fail(error: URLError(.badServerResponse))
            .eraseToAnyPublisher()
    }
}
