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
    var fetchCharactersResult: AnyPublisher<(data: CharactersPageDTO, response: URLResponse), Error>?

    func fetchAllCharacters(withParameters parameters: [String: String]) -> AnyPublisher<(data: CharactersPageDTO, response: URLResponse), Error> {
        if let fetchCharactersResult {
            return fetchCharactersResult
        }
        return Fail(error: URLError(.badServerResponse))
            .eraseToAnyPublisher()
    }
}
